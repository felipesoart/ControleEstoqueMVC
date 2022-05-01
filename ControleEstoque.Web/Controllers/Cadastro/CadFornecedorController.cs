using ControleEstoque.Web.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ControleEstoque.Web.Controllers.Cadastro
{

    [Authorize(Roles = "Gerente,Administrativo,Operador")]
    public class CadFornecedorController : Controller
    {
        private const int _quantMaxLinhasPorPagina = 5;

        // GET: Cadastro

        public ActionResult Index()
        {
            ViewBag.ListaTamPag = new SelectList(new int[] { _quantMaxLinhasPorPagina, 10, 15, 20 }, _quantMaxLinhasPorPagina);
            ViewBag.QuantMaxLinhasPorPagina = _quantMaxLinhasPorPagina;
            ViewBag.PaginaAtual = 1;

            var lista = FornecedorModel.RecuperarLista(ViewBag.PaginaAtual, _quantMaxLinhasPorPagina);
            var quant = FornecedorModel.RecuperarQuantidade();

            var difQuantPaginas = (quant % ViewBag.QuantMaxLinhasPorPagina) > 0 ? 1 : 0;
            ViewBag.QuantPaginas = (quant / ViewBag.QuantMaxLinhasPorPagina) + difQuantPaginas;
            ViewBag.Paises = PaisModel.RecuperarLista();
            //ViewBag.Estados = EstadoModel.RecuperarLista();
            //ViewBag.Cidade = CidadeModel.RecuperarLista();

            return View(lista);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public JsonResult FornecedorPagina(int pagina, int tamPag, string filtro)
        {
            var lista = FornecedorModel.RecuperarLista(pagina, tamPag, filtro);

            return Json(lista);
        }

        //[HttpPost]
        //[ValidateAntiForgeryToken]
        //public JsonResult RecuperarEstadosDoPais(int idPais)
        //{
        //    var lista = EstadoModel.RecuperarLista(idPais: idPais);

        //    return Json(lista);
        //}

        //[HttpPost]
        //[ValidateAntiForgeryToken]
        //public JsonResult RecuperarEstados(int idEstado)
        //{
        //    var lista = EstadoModel.RecuperarLista(idEstado: idEstado);

        //    return Json(lista);
        //}    
        
        [HttpPost]
        [ValidateAntiForgeryToken] //gera o token de altenticação contra CSRF (CROSS )
        public JsonResult RecuperarFornecedor(int id)
        {
            //throw new Exception();//simular um erro de exceção
            return Json(FornecedorModel.RecuperarPeloId(id));
        }

        [HttpPost]
        [Authorize(Roles = "Gerente,Administrativo")]
        [ValidateAntiForgeryToken]
        public JsonResult ExcluirFornecedor(int id)
        {
            /* isso agora faz parte do metodo excluir do FornecedorModel
            var ret = false;

            var registroBD = _listaFornecedor.Find(x => x.Id == id);
            if (registroBD != null)
            {
                _listaFornecedor.Remove(registroBD);
                ret = true;
            }*/

            return Json(FornecedorModel.ExcluirPeloId(id));
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public JsonResult SalvarFornecedor(FornecedorModel model)
        {
            var resultado = "OK";
            var mensagens = new List<string>();
            var idSalvo = string.Empty;

            if (!ModelState.IsValid)
            {
                resultado = "AVISO";
                mensagens = ModelState.Values.SelectMany(x => x.Errors).Select(x => x.ErrorMessage).ToList();

            }
            else
            {
                try
                {
                    var id = model.Salvar();
                    if (id > 0)
                    {
                        idSalvo = id.ToString();
                    }
                    else
                    {
                        resultado = "ERRO";
                    }

                }
                catch (Exception ex)
                {
                    resultado = "ERRO";
                }

            }
            return Json(new { Resultado = resultado, Mensagens = mensagens, IdSalvo = idSalvo });

        }
    }
}