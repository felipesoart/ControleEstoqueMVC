﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace ControleEstoque.Web.Models
{
    public class EsqueciMinhaSenhaViewModel
    {
        [Required(ErrorMessage = "Informe o login")]
        public string Login { get; set; }
    }
}