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
            catch (Exception ex)
            {
                throw ex; //Tratamiento de la excepcion.
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
                throw e; //Tratamiento de la excepcion.
            }
            this.CloseConnection(); // Cierro la conexión.
            return Grupos; // Devuelvo los Grupos.
        }
        //Método para obtener los usuarios de un grupo, en base al id del grupo.
        public List<Usuario> Get_Usuarios_Grupo(Grupo g)
        {
            List<Usuario> Usuarios = new List<Usuario>(); // Listado de usuarios a devolver.
            this.OpenConnection(); // Primero abro la conexión.
            SqlCommand cmd = new SqlCommand("Get_Usuarios_Grupo", cnn); // Nombre del SP a Ejecutar.
            cmd.CommandType = CommandType.StoredProcedure; // Tipo de comando.
            cmd.Parameters.AddWithValue("@v_Grupo_id", g.Id); // Id del grupo.
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
                throw e; //Tratamiento de la excepcion.
            }
            this.CloseConnection(); // Cierro la conexión.
            return Usuarios; // Devuelvo los Usuarios.
        }

        //Método para obtener el listado de sanciones de un usuario, en base a su id.
        public List<Sancion> Get_Sancion_Usuario(Usuario u)
        {
            List<Sancion> Sanciones = new List<Sancion>(); // Listado de sanciones a devolver.
            this.OpenConnection(); // Primero abro la conexión.
            SqlCommand cmd = new SqlCommand("Get_Sancion_Usuario", cnn); // Nombre del SP a Ejecutar.
            cmd.Parameters.AddWithValue("@v_Usuario_id", u.Id); // Id del grupo.
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
                throw e; //Tratamiento de la excepcion.
            }
            this.CloseConnection(); // Cierro la conexión.
            return Sanciones; // Devuelvo los Sanciones
        }
        //Método para obtener el administrador de un determinado grupo.
        public Usuario Get_Administrador_Grupo(Grupo g)
        {
            Usuario Administrador; //Todavía no inicializo la variable.
            this.OpenConnection(); // Primero abro la conexión.
            SqlCommand cmd = new SqlCommand("Get_Sancion_Usuario", cnn); // Nombre del SP a Ejecutar.
            cmd.Parameters.AddWithValue("@v_Grupo_id", g.Id); // Id del grupo.
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
                            Administrador = new Usuario(reader.GetInt32(0), reader.GetString(1), reader.GetString(2), reader.GetString(3));
                            this.CloseConnection(); // Cierro la conexión.
                            return Administrador; // Devuelvo el administrador.
                        }
                    }
                }
            }
            catch (Exception e)
            {
                throw e; //Tratamiento de la excepcion.
            }
            return null; // En el raro caso que el Grupo no tenga Administrador_id.
        }
        //Método para listar los grupos de un usuario determinado.
        public List<Grupo> Get_Grupos_Usuario(Usuario u)
        {
            List<Grupo> Grupos = new List<Grupo>(); // Listado de grupos a devolver.
            this.OpenConnection(); // Primero abro la conexión.
            SqlCommand cmd = new SqlCommand("Get_Grupos_Usuarios", cnn); // Nombre del SP a Ejecutar.
            cmd.Parameters.AddWithValue("@v_Usuario_id", u.Id); // Id del usuario.
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
                throw e; //Tratamiento de la excepcion.
            }
            this.CloseConnection(); // Cierro la conexión.
            return Grupos; // Devuelvo los Grupos
        }
        //Método para crear un nuevo grupo.
        public string Set_Grupo(Grupo g)
        {
            this.OpenConnection(); // Primero abro la conexión.

            SqlCommand cmd = new SqlCommand("Set_Grupo", cnn);
            cmd.CommandType = CommandType.StoredProcedure;
            //Añado los parámetros.
            cmd.Parameters.AddWithValue("@v_Nombre", g.Nombre); ;
            cmd.Parameters.AddWithValue("@v_Descripcion", g.Descripcion);
            cmd.Parameters.AddWithValue("@v_Administrador", g.Administrador_id);
            try
            {
                int rowAffected = cmd.ExecuteNonQuery(); // Ejecuto el SP.
                this.CloseConnection(); // Cierro la conexión.
                return "Grupo creado correctamente";
            }
            catch (Exception e)
            {
                return e.ToString();
            }
        }
        //Método para crear un nuevo usuario.
        public string Set_Usuario(Usuario u)
        {
            this.OpenConnection(); // Primero abro la conexión.

            SqlCommand cmd = new SqlCommand("Set_Usuario", cnn);
            cmd.CommandType = CommandType.StoredProcedure;
            //Añado los parámetros.
            cmd.Parameters.AddWithValue("@v_Usuario", u._Usuario); ;
            cmd.Parameters.AddWithValue("@v_Password", u.Password);
            cmd.Parameters.AddWithValue("@v_Email", u.Email);
            try
            {
                int rowAffected = cmd.ExecuteNonQuery(); // Ejecuto el SP.
                this.CloseConnection(); // Cierro la conexión.
                return "Usuario creado correctamente";
            }
            catch (Exception e)
            {
                return e.ToString();
            }
        }
        //Método estático ya que en el momento del login todavía no hay una instancia de Business, DataAccess, etc.
        public int Login(string usuario, string pass)
        {
            this.OpenConnection(); // Primero abro la conexión.
            SqlCommand cmd = new SqlCommand("Get_Usuario", cnn);
            cmd.CommandType = CommandType.StoredProcedure;

            //Añado los parámetros.
            cmd.Parameters.AddWithValue("@v_Usuario", usuario); ;
            cmd.Parameters.AddWithValue("@v_Password", pass);
            using (SqlDataReader reader = cmd.ExecuteReader())
            {
                if (reader.HasRows) // Si el select devuelve algo, es porque el usuario existe.
                {
                    while (reader.Read()) // Mientras voy leyendo todos los resultados.
                    {
                        int usuario_id = reader.GetInt32(0); // Devuelvo el id_usuario porque con esto se maneja todo después.
                        this.CloseConnection(); // Cierro la conexión.
                        return usuario_id;
                    }
                }
                this.CloseConnection(); // Cierro la conexión.
                return -1; // Usuario no encontrado.
            }

        }
        //Método para agregar un usuario a un determinado grupo.
        public string Set_Usuario_Grupo(Usuario u, Grupo g)
        {
            this.OpenConnection(); // Primero abro la conexión.

            SqlCommand cmd = new SqlCommand("Set_Usuario_Grupo", cnn);
            cmd.CommandType = CommandType.StoredProcedure;
            //Añado los parámetros.
            cmd.Parameters.AddWithValue("@v_Grupo_id", g.Id); ;
            cmd.Parameters.AddWithValue("@v_Usuario_id", u.Id);
            try
            {
                int rowAffected = cmd.ExecuteNonQuery(); // Ejecuto el SP.
                this.CloseConnection(); // Cierro la conexión.
                return u._Usuario + "Agregado a " + g.Nombre;
            }
            catch (Exception e)
            {
                return e.ToString();
            }
        }

        public string Set_Sancion_Usuario(Usuario sancionador, Grupo g, Usuario sancionado, Sancion s)
        {
            this.OpenConnection(); // Primero abro la conexión.

            SqlCommand cmd = new SqlCommand("Set_Sancion", cnn);
            cmd.CommandType = CommandType.StoredProcedure;
            //Añado los parámetros.
            cmd.Parameters.AddWithValue("@v_Grupo_id", g.Id); ;
            cmd.Parameters.AddWithValue("@v_Usuario_creador_id", sancionador.Id);
            cmd.Parameters.AddWithValue("@v_Usuario_sancionado_id", sancionado.Id);
            cmd.Parameters.AddWithValue("@v_Motivo", s.Motivo);
            cmd.Parameters.AddWithValue("@v_Estado", s.Estado);
            cmd.Parameters.AddWithValue("@v_Fecha_creacion", s.Fecha_estado);
            try
            {
                int rowAffected = cmd.ExecuteNonQuery(); // Ejecuto el SP.
                this.CloseConnection(); // Cierro la conexión.
                return "Sancion agregada a:" + sancionado._Usuario;
            }
            catch (Exception e)
            {
                return e.ToString();
            }
        }

        public bool Get_Usuario(string usuario, string email)
        {
            this.OpenConnection(); // Primero abro la conexión.
            SqlCommand cmd = new SqlCommand("Get_Usuario_Email", cnn);
            cmd.CommandType = CommandType.StoredProcedure;

            //Añado los parámetros.
            cmd.Parameters.AddWithValue("@v_Usuario", usuario); ;
            cmd.Parameters.AddWithValue("@v_Email", email);
            try
            {
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.HasRows) // Si el select devuelve algo, es porque el usuario existe.
                    {
                        this.CloseConnection(); // Cierro la conexión.
                        return true;
                    }
                    this.CloseConnection(); // Cierro la conexión.
                    return false;
                }
            }
            catch (Exception)
            {
                return false;
            }
        }
        public string Get_Password_Email(Usuario u)
        {
            this.OpenConnection(); // Primero abro la conexión.
            SqlCommand cmd = new SqlCommand("Get_Password_Email", cnn);
            cmd.CommandType = CommandType.StoredProcedure;

            //Añado los parámetros.
            cmd.Parameters.AddWithValue("@v_Usuario", u._Usuario); ;
            cmd.Parameters.AddWithValue("@v_Email", u.Email);
            try
            {
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.HasRows) // Si el select devuelve algo, es porque el usuario existe.
                    {
                        while (reader.Read()) // Mientras voy leyendo todos los resultados.
                        {
                            string password = reader.GetString(0);
                            this.CloseConnection();
                            return password;
                        }
                    }
                    this.CloseConnection(); // Cierro la conexión.
                    return null;
                }
            }
            catch (Exception e)
            {
                return e.ToString();
            }
        }
        //Método para obtener todas las sanciones de un grupo en estado activo.
        public List<Sancion> Get_Sanciones_Activas_Grupos(Grupo g)
        {
            List<Sancion> Sanciones = new List<Sancion>();
            this.OpenConnection(); // Primero abro la conexión.
            SqlCommand cmd = new SqlCommand("Get_Sanciones_Activas_Grupos", cnn); // Nombre del SP a Ejecutar.
            cmd.Parameters.AddWithValue("@v_Grupo_id", g.Id); // Id del grupos.
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
                throw e; //Tratamiento de la excepcion.
            }
            this.CloseConnection(); // Cierro la conexión.
            return Sanciones; // Devuelvo los Grupos
        }
        //Método para obtener el grupo (por defecto) de un determinado usuario.
        public Grupo Get_Grupo_Determinado_Usuario(Usuario u)
        {
            this.OpenConnection(); // Primero abro la conexión.
            SqlCommand cmd = new SqlCommand("Get_Grupo_Determinado_Usuario", cnn); // Nombre del SP a Ejecutar.
            cmd.Parameters.AddWithValue("@v_Usuario_id", u.Id); // Id del grupos.
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
                            return g;
                        }
                    }
                }
            }
            catch (Exception e)
            {
                throw e; //Tratamiento de la excepcion.
            }
            this.CloseConnection(); // Cierro la conexión.
            return null; // Acá no llega.
        }

        //Método para obtener la cantidad de sanciones por usuario de un determinado grupo.
        public Dictionary<int, int> Get_Cantidad_Sanciones_Usuarios_Grupo(Grupo g)
        {
            Dictionary<int, int> Sanciones = new Dictionary<int, int>();
            this.OpenConnection(); // Primero abro la conexión.
            SqlCommand cmd = new SqlCommand("Get_Cantidad_Sanciones_Usuarios_Grupo", cnn); // Nombre del SP a Ejecutar.
            cmd.Parameters.AddWithValue("@v_Grupo_id", g.Id); // Id del grupos.
            cmd.CommandType = CommandType.StoredProcedure; // Tipo de comando.
            try
            {
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.HasRows) // Si el select devuelve algo.
                    {
                        while (reader.Read()) // Mientras voy leyendo todos los resultados.
                        {
                            Sanciones.Add(reader.GetInt32(0), reader.GetInt32(1));
                        }
                    }
                }
            }
            catch (Exception e)
            {
                throw e; //Tratamiento de la excepcion.
            }
            this.CloseConnection(); // Cierro la conexión.
            return Sanciones; // Devuelvo los Grupos
        }
        public String Get_Nombre_Usuario(Usuario u)
        {
            this.OpenConnection(); // Primero abro la conexión.
            SqlCommand cmd = new SqlCommand("Get_Nombre_Usuario", cnn); // Nombre del SP a Ejecutar.
            cmd.Parameters.AddWithValue("@v_Usuario_id", u.Id); // Id del grupos.
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
                            string nombre = reader.GetString(0);
                            this.CloseConnection();
                            return nombre;
                        }
                    }
                }
            }
            catch (Exception e)
            {
                throw e; //Tratamiento de la excepcion.
            }
            this.CloseConnection(); // Cierro la conexión.
            return null; // Acá no llega.
        }
    }
}
