using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Text;

namespace ControleEstoque.Web.Models
{
    public class UsuarioModel
    {

        public int Id { get; set; }
        [Required(ErrorMessage ="Informe o login!")]
        public string Login { get; set; }

        //[Required(ErrorMessage = "Informe o senha!")]
        public string Senha { get; set; }

        [Required(ErrorMessage = "Informe o nome!")]
        public string Nome { get; set; }

        [Required(ErrorMessage = "Informe o perfil!")]
        public int IdPerfil { get; set; }

        public string Perfil { get; set; }        

        [Required(ErrorMessage = "Informe o email!")]
        public string Email { get; set; }


        //public static UsuarioModel ValidarUsuario(string login, string senha)
        //{
        //    UsuarioModel ret = null;
        //    senha = CriptoHelper.HashMD5(senha);

        //    using (var db = new ContextoBD())
        //    {
        //        ret = db.Usuarios
        //            .Include(x => x.Perfis)
        //            .Where(x => x.Login == login && x.Senha == senha)
        //            .SingleOrDefault();
        //    }

        //    return ret;
        //}

        public static UsuarioModel ValidarUsuario(string login, string senha)
        {
            UsuarioModel ret = null;

            using (var conexao = new SqlConnection())
            {

                conexao.ConnectionString = ConfigurationManager.ConnectionStrings["principal"].ConnectionString;
                conexao.Open();
                using (var comando = new SqlCommand())
                {
                    comando.Connection = conexao;
                    comando.CommandText = "select * from usuario where login=@login and senha=@senha";

                    //comando contra sql inject
                    comando.Parameters.Add("@login", SqlDbType.VarChar).Value = login;
                    comando.Parameters.Add("@senha", SqlDbType.VarChar).Value = CriptoHelper.HashMD5(senha);
                    var reader = comando.ExecuteReader();
                    if (reader.Read())
                    {
                        ret = new UsuarioModel
                        {
                            Id = (int)reader["id"],
                            Login = (string)reader["login"],
                            Senha = (string)reader["senha"],
                            Nome = (string)reader["nome"],
                            IdPerfil = (int)reader["id_perfil"],
                            Email = (string)reader["email"]
                        };
                    }
                }
            }

            return ret;
            
        }

       

        public static int RecuperarQuantidade()
        {
            var ret = 0;

            using (var conexao = new SqlConnection())
            {
                conexao.ConnectionString = ConfigurationManager.ConnectionStrings["principal"].ConnectionString;
                conexao.Open();
                using (var comando = new SqlCommand())
                {
                    comando.Connection = conexao;
                    comando.CommandText = "select count(*) from usuario";
                    ret = (int)comando.ExecuteScalar();
                }
            }

            return ret;

        }

        public static List<UsuarioModel> RecuperarLista(int pagina = -1, int tamPagina = -1)
        {
            var ret = new List<UsuarioModel>();
            using (var conexao = new SqlConnection())
            {

                conexao.ConnectionString = ConfigurationManager.ConnectionStrings["principal"].ConnectionString;
                conexao.Open();
                using (var comando = new SqlCommand())
                {

                    var pos = (pagina - 1) * tamPagina;

                    comando.Connection = conexao;

                    if (pagina == -1 || tamPagina == -1)
                    {
                        comando.CommandText = "select * from usuario order by nome";
                    }
                    else
                    {

                        comando.CommandText = string.Format(
                            "select * from usuario order by nome offset {0} rows fetch next {1} rows only",
                            pos > 0 ? pos : 0, tamPagina);
                    }

                    var reader = comando.ExecuteReader();
                    while (reader.Read())   //enquanto tiver algu a ser lido eu vou fazer algo aqui abaixo
                    {
                        ret.Add(new UsuarioModel
                        {
                            Id = (int)reader["id"],
                            Nome = (string)reader["nome"],
                            Login = (string)reader["login"],
                            IdPerfil = (int)reader["id_perfil"],
                            Email = (string)reader["email"]
                        });
                    }
                }
            }

            return ret;

        }

       

        public static UsuarioModel RecuperarPeloId(int id)
        {
            UsuarioModel ret = null;
            using (var conexao = new SqlConnection())
            {

                conexao.ConnectionString = ConfigurationManager.ConnectionStrings["principal"].ConnectionString;
                conexao.Open();
                using (var comando = new SqlCommand())
                {
                    comando.Connection = conexao;
                    comando.CommandText = "select * from usuario where (id = @id)";

                    //comando contra sql inject
                    comando.Parameters.Add("@id", SqlDbType.Int).Value = id;

                    var reader = comando.ExecuteReader();
                    if (reader.Read())
                    {
                        ret = new UsuarioModel
                        {
                            Id = (int)reader["id"],
                            Nome = (string)reader["nome"],
                            Login = (string)reader["login"],
                            IdPerfil = (int)reader["id_perfil"],
                            Email = (string)reader["email"],                           
                        };
                    }
                }
            }

            return ret;

        }public static UsuarioModel RecuperarPeloIdLogin(string login)
        {
            UsuarioModel ret = null;
            using (var conexao = new SqlConnection())
            {

                conexao.ConnectionString = ConfigurationManager.ConnectionStrings["principal"].ConnectionString;
                conexao.Open();
                using (var comando = new SqlCommand())
                {
                    comando.Connection = conexao;
                    comando.CommandText = "select * from usuario where (login = @login)";

                    //comando contra sql inject
                    comando.Parameters.Add("@login", SqlDbType.VarChar).Value = login;

                    var reader = comando.ExecuteReader();
                    if (reader.Read())
                    {
                        ret = new UsuarioModel
                        {
                            Id = (int)reader["id"],
                            Nome = (string)reader["nome"],
                            Login = (string)reader["login"],
                            IdPerfil = (int)reader["id_perfil"],
                            Email = (string)reader["email"]

                        };
                    }
                }
            }

            return ret;

        }


        

        public static bool ExcluirPeloId(int id)
        {

            var ret = false;
            if (RecuperarPeloId(id) != null)
            {
                using (var conexao = new SqlConnection())
                {

                    conexao.ConnectionString = ConfigurationManager.ConnectionStrings["principal"].ConnectionString;
                    conexao.Open();
                    using (var comando = new SqlCommand())
                    {
                        comando.Connection = conexao;
                        comando.CommandText = "delete from usuario where (id = @id)";

                        //comando contra sql inject
                        comando.Parameters.Add("@id", SqlDbType.Int).Value = id;
                        ret = (comando.ExecuteNonQuery() > 0);

                    }
                }
            }
            return ret;

        }

        public int Salvar()
        {

            var ret = 0;
            var model = RecuperarPeloId(this.Id);

            using (var conexao = new SqlConnection())
            {
                conexao.ConnectionString = ConfigurationManager.ConnectionStrings["principal"].ConnectionString;
                conexao.Open();
                using (var comando = new SqlCommand())
                {
                    comando.Connection = conexao;
                    if (model == null)
                    {
                        comando.CommandText = "insert into usuario (nome, login, email, senha, id_perfil) values (@nome, @login, @email, @senha, @id_perfil); select convert(int, scope_identity())";

                        comando.Parameters.Add("@nome", SqlDbType.VarChar).Value = this.Nome;
                        comando.Parameters.Add("@email", SqlDbType.VarChar).Value = this.Email;
                        comando.Parameters.Add("@login", SqlDbType.VarChar).Value = this.Login;
                        comando.Parameters.Add("@senha", SqlDbType.VarChar).Value = CriptoHelper.HashMD5(this.Senha);
                        comando.Parameters.Add("@id_perfil", SqlDbType.Int).Value = this.IdPerfil;

                        ret = (int)comando.ExecuteScalar();
                    }
                    else
                    {
                        comando.CommandText =
                            "update usuario set nome= @nome, email = @email, login= @login, id_perfil= @id_perfil" +
                            (Senha != "12345678" ? ", senha=@senha" : "") + //!string.IsNullOrEmpty(this.Senha) 
                            " where id= @id";

                        //comando contra sql inject
                        comando.Parameters.Add("@nome", SqlDbType.VarChar).Value = this.Nome;
                        comando.Parameters.Add("@email", SqlDbType.VarChar).Value = this.Email;
                        comando.Parameters.Add("@login", SqlDbType.VarChar).Value = this.Login;
                        comando.Parameters.Add("@id_perfil", SqlDbType.Int).Value = this.IdPerfil;

                        if (!string.IsNullOrEmpty(this.Senha))
                        {
                            comando.Parameters.Add("@senha", SqlDbType.VarChar).Value = CriptoHelper.HashMD5(this.Senha);
                        }

                        comando.Parameters.Add("@id", SqlDbType.Int).Value = Id;

                        if (comando.ExecuteNonQuery() > 0)
                        {
                            ret = this.Id;
                        }
                    }
                }
            }

            return ret;

        }

        public bool ValidarSenhaAtual(string senhaAtual)
        {
            var ret = false;

            using (var conexao = new SqlConnection())
            {
                conexao.ConnectionString = ConfigurationManager.ConnectionStrings["principal"].ConnectionString;
                conexao.Open();
                using (var comando = new SqlCommand())
                {
                    comando.Connection = conexao;

                    comando.CommandText =
                        "select count(*) from usuario where senha= @senhaAtual and id= @id";

                    //comando contra sql inject
                    comando.Parameters.Add("@id", SqlDbType.Int).Value = this.Id;
                    comando.Parameters.Add("@senhaAtual", SqlDbType.VarChar).Value = CriptoHelper.HashMD5(senhaAtual);

                    ret = ((int)comando.ExecuteScalar() > 0);
                }
            }

            return ret;
        }

        public string RecuperarStringNomePerfis()
        {           
            var ret = string.Empty;

            using (var conexao = new SqlConnection())
            {
                conexao.ConnectionString = ConfigurationManager.ConnectionStrings["principal"].ConnectionString;
                conexao.Open();
                using (var comando = new SqlCommand())
                {
                    comando.Connection = conexao;

                    comando.CommandText =
                        "select perfil.nome from perfil_usuario inner join perfil on perfil.id = perfil_usuario.id_perfil where id_usuario = @id";

                    comando.Parameters.Add("@id", SqlDbType.Int).Value = Id;

                    var reader = comando.ExecuteReader();
                    if (reader.Read())
                    {
                        this.Perfil = (string)reader["nome"];
                       
                    }
                }
            }

            if (!string.IsNullOrEmpty(this.Perfil))
            {
                ret = string.Join(";", Perfil);
            }

            return ret;
        }

        public bool AlterarSalvar(string novaSenha)
        {

            var ret = false;
         
            using (var conexao = new SqlConnection())
            {
                conexao.ConnectionString = ConfigurationManager.ConnectionStrings["principal"].ConnectionString;
                conexao.Open();
                using (var comando = new SqlCommand())
                {
                    comando.Connection = conexao;

                    comando.CommandText =
                        "update usuario set senha= @senha where id= @id";

                        //comando contra sql inject
                        comando.Parameters.Add("@id", SqlDbType.Int).Value = this.Id;
                        comando.Parameters.Add("@senha", SqlDbType.VarChar).Value = CriptoHelper.HashMD5(novaSenha);

                    ret = (comando.ExecuteNonQuery() > 0);
                }
            }

            return ret;

        }
    }
}