using ControleEstoque.Web.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;

namespace ControleEstoque.Web.Controllers
{
    public class ContaController : Controller
    {
        [AllowAnonymous]
        public ActionResult Login(string returnUrl)
        {
            ViewBag.ReturnUrl = returnUrl;
            return View();
        }

        [HttpPost]
        [AllowAnonymous]
        public ActionResult Login(LoginViewModel login, string returnUrl)
        {
            if (!ModelState.IsValid)
            {
                return View(login);
            }

            var usuario = UsuarioModel.ValidarUsuario(login.Usuario, login.Senha);

            if (usuario != null)
            {
                var ticket = FormsAuthentication.Encrypt(new FormsAuthenticationTicket(
                  1, usuario.Nome, DateTime.Now, DateTime.Now.AddHours(12), login.LembrarMe, usuario.Id + "|" + usuario.RecuperarStringNomePerfis()));/*PerfilModel.RecuperarPeloId(usuario.IdPerfil).Nome));*/
                var cookie = new HttpCookie(FormsAuthentication.FormsCookieName, ticket);
                Response.Cookies.Add(cookie);

                if (Url.IsLocalUrl(returnUrl))
                {
                    return Redirect(returnUrl);
                }
                else
                {
                    return RedirectToAction("Index", "Home");
                }
            }
            else
            {
                ModelState.AddModelError("", "Login inválido.");
            }

            return View(login);
        }

        [HttpPost]
        [AllowAnonymous]
        public ActionResult LogOff()
        {
            FormsAuthentication.SignOut();
            return RedirectToAction("Index", "Home");
        }

        [AllowAnonymous]
        public ActionResult AlterarSenhaUsuario(AlterarSenhaUsuarioViewModel model)
        {
            ViewBag.Mensagem = null;
            if (HttpContext.Request.HttpMethod.ToUpper() == "POST")
            {
                var usuarioLogado = (HttpContext.User as AplicacaoPrincipal);
                var alterou = false;
                if (usuarioLogado != null)
                {
                    if (!usuarioLogado.Dados.ValidarSenhaAtual(model.SenhaAtual))
                    {
                        ModelState.AddModelError("SenhaAtual", "A senha atual não confere.");
                    }
                    else
                    {
                        alterou = usuarioLogado.Dados.AlterarSalvar(model.NovaSenha);
                        if (alterou)
                        {
                            ViewBag.Mensagem = new string[] { "ok", "Senha alterada com sucesso." };
                        }
                        else
                        {
                            ViewBag.Mensagem = new string[] { "erro", "Não foi possível alterar a senha." };
                        }
                    }
                   
                }
                return View();
            }
            else {//quando for get ele simplismente não precisa mostra nenhuma msg
                ModelState.Clear();
                return View(); 
            }
            
        }

        [AllowAnonymous]
        public ActionResult EsqueciMinhaSenha(EsqueciMinhaSenhaViewModel model)
        {
            ViewBag.EmailEnviado = true;
            if (HttpContext.Request.HttpMethod.ToUpper() == "GET")
            {
                ViewBag.EmailEnviado = false;
                ModelState.Clear();
            }
            else
            {
                var usuario = UsuarioModel.RecuperarPeloIdLogin(model.Login);
                if (usuario != null)
                {
                    EnviarEmailRedefinicaoSenha(usuario);
                }
            }
            return View(model);
        }

        [AllowAnonymous]
        public ActionResult RedefinirSenha(int id)
        {
            var usuario = UsuarioModel.RecuperarPeloId(id);
            if(usuario == null)
            {
                id = -1;
            }

            var model = new NovaSenhaViewModel() { Usuario = id };

            //ViewBag.Usuario = usuario;
            ViewBag.Mensagem = null;

            return View(model);
        }

        [HttpPost]
        [AllowAnonymous]
        public ActionResult RedefinirSenha(NovaSenhaViewModel model)
        {
            ViewBag.Mensagem = null;
            if (!ModelState.IsValid)
            {
                return View(model);
            }
            var usuario = UsuarioModel.RecuperarPeloId(model.Usuario);
            if (usuario != null)
            {
                var ok = usuario.AlterarSalvar(model.Senha);
                ViewBag.Mensagem = ok ? "Senha alterada com sucesso!" : "Não foi possível alterar a senha!";
            }

            return View();
        }

            private void EnviarEmailRedefinicaoSenha(UsuarioModel usuario)
        {
            var callbackUrl = Url.Action("RedefinirSenha", "conta", new { id = usuario.Id }, protocol: Request.Url.Scheme);
            var client = new SmtpClient()
            {
                Host = ConfigurationManager.AppSettings["EmailServidor"],
                Port = Convert.ToInt32(ConfigurationManager.AppSettings["EmailPorta"]),
                EnableSsl = (ConfigurationManager.AppSettings["EmailSsl"] == "S"),
                UseDefaultCredentials = false,
                DeliveryMethod = SmtpDeliveryMethod.Network,
                Credentials = new NetworkCredential(
                    ConfigurationManager.AppSettings["EmailUsuario"],
                    ConfigurationManager.AppSettings["EmailSenha"])
            };
            var mensagem = new MailMessage();
            mensagem.From = new MailAddress(ConfigurationManager.AppSettings["EmailOrigem"], "Controla de Estoque - Como Programar Melhor");
            mensagem.To.Add(usuario.Email);
            mensagem.Subject = "Redefinição de Senha";
            mensagem.Body = string.Format("Redefinição a sua senha <a href='{0}'>aqui</a>", callbackUrl);
            mensagem.IsBodyHtml = true;

            client.Send(mensagem);
        }
    }
}