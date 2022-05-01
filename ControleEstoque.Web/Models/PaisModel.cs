using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace ControleEstoque.Web.Models
{
    public class PaisModel
    {
        public int Id { get; set; }

        [Required(ErrorMessage = "Preencha o nome.")]
        [MaxLength(30, ErrorMessage ="O nome pode ter no máximo 30 caracteres.")]
        //[AllowHtml] //- serve para poder fazer tag htlm em campos de input no ambiente de depuração  
        public string Nome { get; set; }

        [Required(ErrorMessage = "Preencha o codigo internacional.")]
        [MaxLength(3, ErrorMessage = "O codigo internacional deve ter 3 caracteres.")]
        public string Codigo { get; set; }

        public bool Ativo { get; set; }

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
                    comando.CommandText = "select count(*) from pais";
                    ret = (int)comando.ExecuteScalar();
                }
            }

            return ret;

        }

        public static List<PaisModel> RecuperarLista(int pagina = 0, int tamPagina = 0, string filtro = "")
        {
            var ret = new List<PaisModel>();
            using (var conexao = new SqlConnection())
            {
                conexao.ConnectionString = ConfigurationManager.ConnectionStrings["principal"].ConnectionString;
                conexao.Open();
                using (var comando = new SqlCommand())
                {

                    var pos = (pagina - 1) * tamPagina;

                    var filtroWhere = "";
                    if (!string.IsNullOrEmpty(filtro))
                    {
                        filtroWhere = string.Format(" where lower(nome) like '%{0}%'", filtro.ToLower());
                    }

                    //poderia ser usado este scrip a baixa podem ele é muito feio, melhor usar da forma que esta acima ^^
                    //var filtroWhere =
                    //    string.IsNullOrEmpty(filtro) ? "" :
                    //    string.Format(" where lower(nome) like '%{0}%'", filtro.ToLower());
                    var paginacao = "";
                    if (pagina > 0 && tamPagina > 0)
                    {
                        paginacao = string.Format(" offset {0} rows fetch next {1} rows only",
                        pos > 0 ? pos : 0, tamPagina);
                    }

                    comando.Connection = conexao;
                    comando.CommandText = 
                        "select *" +
                        " from pais" +
                        filtroWhere +
                        " order by nome" +                       
                        paginacao;

                    var reader = comando.ExecuteReader();
                    while (reader.Read())   //enquanto tiver algu a ser lido eu vou fazer algo aqui abaixo
                    {
                        ret.Add(new PaisModel
                        {
                            Id = (int)reader["id"],
                            Nome = (string)reader["nome"],
                            Codigo = (string)reader["codigo"],
                            Ativo = (bool)reader["ativo"]
                        });
                    }
                }
            }

            return ret;

        }

       

        public static PaisModel RecuperarPeloId(int id)
        {
            PaisModel ret = null;
            using (var conexao = new SqlConnection())
            {

                conexao.ConnectionString = ConfigurationManager.ConnectionStrings["principal"].ConnectionString;
                conexao.Open();
                using (var comando = new SqlCommand())
                {
                    comando.Connection = conexao;
                    comando.CommandText = "select * from pais where (id = @id)";

                    //comando contra sql inject
                    comando.Parameters.Add("@id", SqlDbType.Int).Value = id;

                    var reader = comando.ExecuteReader();
                    if (reader.Read())
                    {
                        ret = new PaisModel
                        {
                            Id = (int)reader["id"],
                            Nome = (string)reader["nome"],
                            Codigo = (string)reader["codigo"],
                            Ativo = (bool)reader["ativo"]
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
                        comando.CommandText = "delete from pais where (id = @id)";

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
                        comando.CommandText = "insert into pais (nome, codigo, ativo) values (@nome, @codigo, @ativo); select convert(int, scope_identity())";

                        comando.Parameters.Add("@nome", SqlDbType.VarChar).Value = this.Nome;
                        comando.Parameters.Add("@codigo", SqlDbType.VarChar).Value = this.Codigo;
                        comando.Parameters.Add("@ativo", SqlDbType.VarChar).Value = (this.Ativo ? 1 : 0);
                        comando.Parameters.Add("@id", SqlDbType.Int).Value = Id;

                        ret = (int)comando.ExecuteScalar();
                    }
                    else
                    {
                        comando.CommandText =
                            "update pais set nome= @nome, codigo=@codigo, ativo=@ativo where id= @id";

                        //comando contra sql inject
                        comando.Parameters.Add("@nome", SqlDbType.VarChar).Value = this.Nome;
                        comando.Parameters.Add("@codigo", SqlDbType.VarChar).Value = this.Codigo;
                        comando.Parameters.Add("@ativo", SqlDbType.VarChar).Value = (this.Ativo ? 1 : 0);
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
    }
}