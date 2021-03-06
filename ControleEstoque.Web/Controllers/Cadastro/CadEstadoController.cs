using ControleEstoque.Web.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ControleEstoque.Web.Controllers.Cadastro
{
    [Authorize(Roles = "Gerente,Administrativo,Operador")]
    public class CadEstadoController : Controller
    {      
        private const int _quantMaxLinhasPorPagina = 5;

        // GET: Cadastro

        public ActionResult Index()
        {
            ViewBag.ListaTamPag = new SelectList(new int[] { _quantMaxLinhasPorPagina, 10, 15, 20 }, _quantMaxLinhasPorPagina);
            ViewBag.QuantMaxLinhasPorPagina = _quantMaxLinhasPorPagina;
            ViewBag.PaginaAtual = 1;

            var lista = EstadoModel.RecuperarLista(ViewBag.PaginaAtual, _quantMaxLinhasPorPagina);
            var quant = EstadoModel.RecuperarQuantidade();

            var difQuantPaginas = (quant % ViewBag.QuantMaxLinhasPorPagina) > 0 ? 1 : 0;
            ViewBag.QuantPaginas = (quant / ViewBag.QuantMaxLinhasPorPagina) + difQuantPaginas;
            ViewBag.Paises = PaisModel.RecuperarLista();

            return View(lista);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public JsonResult EstadoPagina(int pagina, int tamPag, string filtro)
        {
            var lista = EstadoModel.RecuperarLista(pagina, tamPag, filtro);

            return Json(lista);
        }
                
        [HttpPost]
        [ValidateAntiForgeryToken]
        public JsonResult RecuperarEstadosDoPais(int idPais)
        {
            var lista = EstadoModel.RecuperarLista(idPais: idPais);

            return Json(lista);
        }
                
        [HttpPost]
        [ValidateAntiForgeryToken]
        public JsonResult RecuperarEstados(int idEstado)
        {
            var lista = EstadoModel.RecuperarLista(idEstado: idEstado);

            return Json(lista);
        }

        [HttpPost]
        [ValidateAntiForgeryToken] //gera o token de altenticação contra CSRF (CROSS )
        public JsonResult RecuperarEstado(int id)
        {
            //throw new Exception();//simular um erro de exceção
            return Json(EstadoModel.RecuperarPeloId(id));
        }

        [HttpPost]
        [Authorize(Roles = "Gerente,Administrativo")]
        [ValidateAntiForgeryToken]
        public JsonResult ExcluirEstado(int id)
        {
            /* isso agora faz parte do metodo excluir do EstadoModel
            var ret = false;

            var registroBD = _listaEstado.Find(x => x.Id == id);
            if (registroBD != null)
            {
                _listaEstado.Remove(registroBD);
                ret = true;
            }*/

            return Json(EstadoModel.ExcluirPeloId(id));
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public JsonResult SalvarEstado(EstadoModel model)
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