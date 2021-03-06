using ControleEstoque.Web.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ControleEstoque.Web.Controllers.Cadastro
{
    [Authorize(Roles = "Gerente,Administrativo,Operador")]
    public class CadPaisController : Controller
    {
        private const int _quantMaxLinhasPorPagina = 5;

        // GET: Cadastro

        public ActionResult Index()
        {
            ViewBag.ListaTamPag = new SelectList(new int[] { _quantMaxLinhasPorPagina, 10, 15, 20 }, _quantMaxLinhasPorPagina);
            ViewBag.QuantMaxLinhasPorPagina = _quantMaxLinhasPorPagina;
            ViewBag.PaginaAtual = 1;

            var lista = PaisModel.RecuperarLista(ViewBag.PaginaAtual, _quantMaxLinhasPorPagina);
            var quant = PaisModel.RecuperarQuantidade();

            var difQuantPaginas = (quant % ViewBag.QuantMaxLinhasPorPagina) > 0 ? 1 : 0;
            ViewBag.QuantPaginas = (quant / ViewBag.QuantMaxLinhasPorPagina) + difQuantPaginas;

            return View(lista);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public JsonResult PaisPagina(int pagina, int tamPag, string filtro)
        {
            var lista = PaisModel.RecuperarLista(pagina, tamPag, filtro);

            return Json(lista);
        }

        [HttpPost]
        [ValidateAntiForgeryToken] //gera o token de altenticação contra CSRF (CROSS )
        public JsonResult RecuperarPais(int id)
        {
            //throw new Exception();//simular um erro de exceção
            return Json(PaisModel.RecuperarPeloId(id));
        }

        [HttpPost]
        [Authorize(Roles = "Gerente,Administrativo")]
        [ValidateAntiForgeryToken]
        public JsonResult ExcluirPais(int id)
        {
            /* isso agora faz parte do metodo excluir do PaisModel
            var ret = false;

            var registroBD = _listaPais.Find(x => x.Id == id);
            if (registroBD != null)
            {
                _listaPais.Remove(registroBD);
                ret = true;
            }*/

            return Json(PaisModel.ExcluirPeloId(id));
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public JsonResult SalvarPais(PaisModel model)
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