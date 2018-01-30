using SISA.DataAccess.Interfaces;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SISA.Common;
using System.Data;

namespace SISA.DataAccess
{
    public class O_DataAccess : IDataAccess
    {
        private string _connectionString; // Variable privada que tiene el string de conexión.
        SqlConnection cnn; // Variable privada que tiene la conexión(OBJETO) de SQL.
        public string ConnectionString
        {
            get { return _connectionString; }
            set { _connectionString = value; }
        }
        //Constructor por defecto.
        public O_DataAccess(string _connectionString)
        {
            this._connectionString = _connectionString;
        }
        //Método básico para abrir la conexión.
        public void OpenConnection()
        {
            cnn = new SqlConnection(_connectionString);
            try
            {
                cnn.Open();
            }
            catch (Exception ex) //Capturo la excepción.
            {
                throw ex;
            }
        }
        //Método básico para cerrar la conexión.
        public void CloseConnection()
        {
            cnn.Close();
        }
        //Método para obtener el listado de todos los grupos.
        public List<Grupo> Get_Grupos()
        {
            List<Grupo> Grupos = new List<Grupo>(); // Listado de grupos a devolver.
            this.OpenConnection(); // Primero abro la conexión.
            SqlCommand cmd = new SqlCommand("Get_Grupos", cnn); // Nombre del SP a Ejecutar.
            cmd.CommandType = CommandType.StoredProcedure; // Tipo de comando.
            try
            {
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.HasRows) // Si el select devuelve algo.
                    {
                        while (reader.Read()) // Mientras voy leyendo todos los resultados.
                        {
                            //Creo una variable auxiliar que va leyendo registro por registro.
                            Grupo g = new Grupo(reader.GetInt32(0), reader.GetString(1), reader.GetString(2), reader.GetInt32(3));
                            Grupos.Add(g);
                        }
                    }
                }
            }
            catch (Exception e)
            {
                return null;
            }
            this.CloseConnection(); // Cierro la conexión.
            return Grupos; // Devuelvo los Grupos.
        }

        public List<Usuario> Get_Usuarios_Grupo(Grupo g)
        {
            List<Usuario> Usuarios = new List<Usuario>(); // Listado de usuarios a devolver.
            this.OpenConnection(); // Primero abro la conexión.
            SqlCommand cmd = new SqlCommand("Get_Usuarios_Grupo", cnn); // Nombre del SP a Ejecutar.
            cmd.CommandType = CommandType.StoredProcedure; // Tipo de comando.
            try
            {
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.HasRows) // Si el select devuelve algo.
                    {
                        while (reader.Read()) // Mientras voy leyendo todos los resultados.
                        {
                            //Creo una variable auxiliar que va leyendo registro por registro.
                            Usuario p = new Usuario(reader.GetInt32(0), reader.GetString(1), reader.GetString(2), reader.GetString(3));
                            Usuarios.Add(p);
                        }
                    }
                }
            }
            catch (Exception e)
            {
                return null;
            }
            this.CloseConnection(); // Cierro la conexión.
            return Usuarios; // Devuelvo los Usuarios.
        }

        public List<Sancion> Get_Sancion_Usuario(Usuario u)
        {
            List<Sancion> Sanciones = new List<Sancion>(); // Listado de sanciones a devolver.
            this.OpenConnection(); // Primero abro la conexión.
            SqlCommand cmd = new SqlCommand("Get_Sancion_Usuario", cnn); // Nombre del SP a Ejecutar.
            cmd.CommandType = CommandType.StoredProcedure; // Tipo de comando.
            try
            {
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.HasRows) // Si el select devuelve algo.
                    {
                        while (reader.Read()) // Mientras voy leyendo todos los resultados.
                        {
                            //Creo una variable auxiliar que va leyendo registro por registro.
                            Sancion s = new Sancion(reader.GetInt32(0), reader.GetInt32(1), reader.GetInt32(2), reader.GetInt32(3), reader.GetString(4), reader.GetInt32(5), reader.GetDateTime(6));
                            Sanciones.Add(s);
                        }
                    }
                }
            }
            catch (Exception e)
            {
                return null;
            }
            this.CloseConnection(); // Cierro la conexión.
            return Sanciones; // Devuelvo los Sanciones
        }

        public Usuario Get_Administrador_Grupo(Grupo g)
        {
            throw new NotImplementedException();
        }
    }
}
