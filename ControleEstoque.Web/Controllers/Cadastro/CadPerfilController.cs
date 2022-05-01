﻿using ControleEstoque.Web.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;

namespace ControleEstoque.Web.Controllers.Cadastro
{
    [Authorize(Roles = "Gerente")]
    public class CadPerfilController : Controller
    {
        private const int _quantMaxLinhasPorPagina = 5;

        // GET: Cadastro

        public ActionResult Index()
        {
            ViewBag.ListaUsuario = UsuarioModel.RecuperarLista();
            ViewBag.ListaTamPag = new SelectList(new int[] { _quantMaxLinhasPorPagina, 10, 15, 20 }, _quantMaxLinhasPorPagina);
            ViewBag.QuantMaxLinhasPorPagina = _quantMaxLinhasPorPagina;
            ViewBag.PaginaAtual = 1;

            var lista = PerfilModel.RecuperarLista(ViewBag.PaginaAtual, _quantMaxLinhasPorPagina);
            var quant = PerfilModel.RecuperarQuantidade();

            var difQuantPaginas = (quant % ViewBag.QuantMaxLinhasPorPagina) > 0 ? 1 : 0;
            ViewBag.QuantPaginas = (quant / ViewBag.QuantMaxLinhasPorPagina) + difQuantPaginas;

            return View(lista);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public JsonResult PerfilPagina(int pagina, int tamPag)
        {

            var lista = PerfilModel.RecuperarLista(pagina, tamPag);

            return Json(lista);
        }

        [HttpPost]
        [ValidateAntiForgeryToken] //gera o token de altenticação contra CSRF (CROSS )
        public JsonResult RecuperarPerfil(int id)
        {
            var ret = PerfilModel.RecuperarPeloId(id);
            ret.CarregarUsuarios();
            return Json(ret);
        }

        [HttpPost]      
        [ValidateAntiForgeryToken]
        public JsonResult ExcluirPerfil(int id)
        {
            /* isso agora faz parte do metodo excluir do PerfilModel
            var ret = false;

            var registroBD = _listaPerfil.Find(x => x.Id == id);
            if (registroBD != null)
            {
                _listaPerfil.Remove(registroBD);
                ret = true;
            }*/

            return Json(PerfilModel.ExcluirPeloId(id));
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public JsonResult SalvarPerfil(PerfilModel model, List<int> idUsuarios)
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

                model.Usuarios = new List<UsuarioModel>();
                if (idUsuarios == null || idUsuarios.Count == 0)
                {
                    model.Usuarios.Add(new UsuarioModel() { Id = -1 });
                }
                else
                {
                    foreach (var id in idUsuarios)
                    {
                        model.Usuarios.Add(new UsuarioModel() { Id = id });
                    }
                }
                

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