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
    public class LocalArmazenamentoModel
    {
        public int Id { get; set; }

        [Required(ErrorMessage = "Preencha o nome.")]
        //[AllowHtml] //- serve para poder fazer tag htlm em campos de input no ambiente de depuração  
        public string Nome { get; set; }

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
                    comando.CommandText = "select count(*) from local_armazenamento";
                    ret = (int)comando.ExecuteScalar();
                }
            }

            return ret;

        }

        public static List<LocalArmazenamentoModel> RecuperarLista(int pagina, int tamPagina)
        {
            var ret = new List<LocalArmazenamentoModel>();
            using (var conexao = new SqlConnection())
            {
                conexao.ConnectionString = ConfigurationManager.ConnectionStrings["principal"].ConnectionString;
                conexao.Open();
                using (var comando = new SqlCommand())
                {

                    var pos = (pagina - 1) * tamPagina;

                    comando.Connection = conexao;
                    comando.CommandText = string.Format(
                        "select * from local_armazenamento order by nome offset {0} rows fetch next {1} rows only",
                        pos > 0 ? pos : 0, tamPagina);
                    var reader = comando.ExecuteReader();
                    while (reader.Read())   //enquanto tiver algu a ser lido eu vou fazer algo aqui abaixo
                    {
                        ret.Add(new LocalArmazenamentoModel
                        {
                            Id = (int)reader["id"],
                            Nome = (string)reader["nome"],
                            Ativo = (bool)reader["ativo"]
                        });
                    }
                }
            }

            return ret;

        }

        public static LocalArmazenamentoModel RecuperarPeloId(int id)
        {
            LocalArmazenamentoModel ret = null;
            using (var conexao = new SqlConnection())
            {

                conexao.ConnectionString = ConfigurationManager.ConnectionStrings["principal"].ConnectionString;
                conexao.Open();
                using (var comando = new SqlCommand())
                {
                    comando.Connection = conexao;
                    comando.CommandText = "select * from local_armazenamento where (id = @id)";

                    //comando contra sql inject
                    comando.Parameters.Add("@id", SqlDbType.Int).Value = id;

                    var reader = comando.ExecuteReader();
                    if (reader.Read())
                    {
                        ret = new LocalArmazenamentoModel
                        {
                            Id = (int)reader["id"],
                            Nome = (string)reader["nome"],
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
                        comando.CommandText = "delete from local_armazenamento where (id = @id)";

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
                        comando.CommandText = "insert into local_armazenamento (nome, ativo) values (@nome,@ativo); select convert(int, scope_identity())";

                        comando.Parameters.Add("@nome", SqlDbType.VarChar).Value = this.Nome;
                        comando.Parameters.Add("@ativo", SqlDbType.VarChar).Value = (this.Ativo ? 1 : 0);
                        comando.Parameters.Add("@id", SqlDbType.Int).Value = Id;

                        ret = (int)comando.ExecuteScalar();
                    }
                    else
                    {
                        comando.CommandText =
                            "update local_armazenamento set nome= @nome, ativo=@ativo where id= @id";

                        //comando contra sql inject
                        comando.Parameters.Add("@nome", SqlDbType.VarChar).Value = this.Nome;
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