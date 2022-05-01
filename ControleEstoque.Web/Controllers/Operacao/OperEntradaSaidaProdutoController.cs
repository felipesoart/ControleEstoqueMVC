using ControleEstoque.Web.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ControleEstoque.Web.Controllers.Operacao
{
    public abstract class OperEntradaSaidaProdutoController : Controller
    {
        // GET: OperEntradaProduto
        public ActionResult Index()
        {
            ViewBag.Produtos = ProdutoModel.RecuperarLista(somenteAtivos: true);
            return View();
        }

        protected abstract string SalvarPedido(EntradaSaidaProdutoViewModel dados);

        public JsonResult Salvar([ModelBinder(typeof(EntradaSaidaProdutoViewModelBinder))]EntradaSaidaProdutoViewModel dados)
        {
            var numPedido = SalvarPedido(dados);
            var ok = (numPedido != "");

            return Json(new { OK = ok, Numero = numPedido });
        }
    }
}