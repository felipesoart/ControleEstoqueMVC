using ControleEstoque.Web.Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ControleEstoque.Web.Controllers
{
    public class HotSiteController : Controller
    {

        private const int _quantMaxLinhasPorPagina = 5;

        // GET: Cadastro

        public ActionResult Index()
        {
            ViewBag.ListaTamPag = new SelectList(new int[] { _quantMaxLinhasPorPagina, 10, 15, 20 }, _quantMaxLinhasPorPagina);
            ViewBag.QuantMaxLinhasPorPagina = _quantMaxLinhasPorPagina;
            ViewBag.PaginaAtual = 1;

            var lista = HotSiteModel.RecuperarLista(ViewBag.PaginaAtual, _quantMaxLinhasPorPagina);
            var quant = HotSiteModel.RecuperarQuantidade();

            var difQuantPaginas = (quant % ViewBag.QuantMaxLinhasPorPagina) > 0 ? 1 : 0;
            ViewBag.QuantPaginas = (quant / ViewBag.QuantMaxLinhasPorPagina) + difQuantPaginas;
            ViewBag.UnidadesMedida = UnidadeMedidaModel.RecuperarLista(1, 9999);
            ViewBag.Grupos = GrupoProdutoModel.RecuperarLista(1, 9999);
            ViewBag.Marcas = MarcaProdutoModel.RecuperarLista(1, 9999);
            ViewBag.Fornecedores = FornecedorModel.RecuperarLista(1, 9999);
            ViewBag.LocaisArmazenamento = LocalArmazenamentoModel.RecuperarLista(1, 9999);

            return View(lista);
            //return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public JsonResult ProdutoPagina(int pagina, int tamPag, string filtro)
        {
            var lista = HotSiteModel.RecuperarLista(pagina, tamPag, filtro);

            return Json(lista);
        }

        [HttpPost]
        [ValidateAntiForgeryToken] //gera o token de altenticação contra CSRF (CROSS )
        public JsonResult RecuperarProduto(int id)
        {
            //throw new Exception();//simular um erro de exceção
            return Json(HotSiteModel.RecuperarPeloId(id));
        }

        [HttpPost]
        //[Authorize(Roles = "Gerente,Administrativo")]
        [ValidateAntiForgeryToken]
        public JsonResult ExcluirProduto(int id)
        {
            /* isso agora faz parte do metodo excluir do HotSiteModel
            var ret = false;

            var registroBD = _listaProduto.Find(x => x.Id == id);
            if (registroBD != null)
            {
                _listaProduto.Remove(registroBD);
                ret = true;
            }*/

            var nomeArquivoImagemAnterior = "";
            if (id > 0)
            {
                nomeArquivoImagemAnterior = HotSiteModel.RecuperarImagemPeloId(id);
            }

            var diretorio = Server.MapPath("~/Content/Imagens");

            if (!string.IsNullOrEmpty(nomeArquivoImagemAnterior))
            {
                var caminhoArquivoAnterior = Path.Combine(diretorio, nomeArquivoImagemAnterior);
                System.IO.File.Delete(caminhoArquivoAnterior);
            }

            return Json(HotSiteModel.ExcluirPeloId(id));
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public JsonResult SalvarProduto()
        {
            var resultado = "OK";
            var mensagens = new List<string>();
            var idSalvo = string.Empty;

            var nomeArquivoImagem = "OK";
            HttpPostedFileBase arquivo = null;
            if (Request.Files.Count > 0)
            {
                arquivo = Request.Files[0];
                nomeArquivoImagem = Guid.NewGuid().ToString() + ".jpg"; //Path.GetFileName(arquivo.FileName); estava assim por conta do nome q pode se repetir colocamos um numero randomico
            }
            var model = new HotSiteModel()
            {
                Id = Int32.Parse(Request.Form["Id"]),
                Codigo = Request.Form["Codigo"],
                Nome = Request.Form["Nome"],
                PrecoCusto = Decimal.Parse(Request.Form["PrecoCusto"]),
                PrecoVenda = Decimal.Parse(Request.Form["PrecoVenda"]),
                QuantEstoque = Int32.Parse(Request.Form["QuantEstoque"]),
                IdUnidadeMedida = Int32.Parse(Request.Form["IdUnidadeMedida"]),
                IdGrupo = Int32.Parse(Request.Form["IdGrupo"]),
                IdMarca = Int32.Parse(Request.Form["IdMarca"]),
                IdFornecedor = Int32.Parse(Request.Form["IdFornecedor"]),
                IdLocalArmazenamento = Int32.Parse(Request.Form["IdLocalArmazenamento"]),
                Ativo = (Request.Form["Ativo"] == "true"),
                Imagem = nomeArquivoImagem
            };

            if (!ModelState.IsValid)
            {
                resultado = "AVISO";
                mensagens = ModelState.Values.SelectMany(x => x.Errors).Select(x => x.ErrorMessage).ToList();

            }
            else
            {
                try
                {

                    var nomeArquivoImagemAnterior = "";
                    if (model.Id > 0)
                    {
                        nomeArquivoImagemAnterior = HotSiteModel.RecuperarImagemPeloId(model.Id);
                    }

                    var id = model.Salvar();
                    if (id > 0)
                    {
                        idSalvo = id.ToString();
                        if (!string.IsNullOrEmpty(nomeArquivoImagem) && arquivo != null)
                        {
                            var diretorio = Server.MapPath("~/Content/Imagens");

                            var caminhoArquivo = Path.Combine(diretorio, nomeArquivoImagem);
                            arquivo.SaveAs(caminhoArquivo);

                            if (!string.IsNullOrEmpty(nomeArquivoImagemAnterior))
                            {
                                var caminhoArquivoAnterior = Path.Combine(diretorio, nomeArquivoImagemAnterior);
                                System.IO.File.Delete(caminhoArquivoAnterior);
                            }
                        }
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