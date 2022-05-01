using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace ControleEstoque.Web.Models
{
    public class AlterarSenhaUsuarioViewModel
    {
        [Required(ErrorMessage = "Preencha a senha atual.")]
        [Display (Name = "Senha Atual")]
        public string SenhaAtual { get; set; }

        [Required(ErrorMessage = "Preencha a nova senha.")]
        [MaxLength(3, ErrorMessage = "A nova senha deve ter no mínimo 3 caracteres.")]
        [Display(Name = "Nova Senha")]
        public string NovaSenha { get; set; }

        [Required(ErrorMessage = "Preencha a confirmação de nova senha.")]
        [Compare("NovaSenha", ErrorMessage = "A senha e a confirmação devem ser iguis.")]
        [Display(Name = "Confirmação da Nova Senha")]
        public string ConfirmacaoNovaSenha { get; set; }
    }
}