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
        //Método que devuelve todos los usuarios del sistema.
        public List<Usuario> Get_Usuarios()
        {
            List<Usuario> Usuarios = new List<Usuario>();
            this.OpenConnection(); // Primero abro la conexión.
            SqlCommand cmd = new SqlCommand("Get_Usuarios", cnn); // Nombre del SP a Ejecutar.
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
                            Usuario u = new Usuario(reader.GetInt32(0), reader.GetString(1), reader.GetString(2), reader.GetString(3));
                            Usuarios.Add(u);
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
        public List<Sancion> Get_Sancion_Usuario(Usuario u, Grupo g)
        {
            List<Sancion> Sanciones = new List<Sancion>(); // Listado de sanciones a devolver.
            this.OpenConnection(); // Primero abro la conexión.
            SqlCommand cmd = new SqlCommand("Get_Sancion_Usuario", cnn); // Nombre del SP a Ejecutar.
            cmd.Parameters.AddWithValue("@v_Usuario_id", u.Id); // Id del usuario.
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
        public string Set_Grupo(Grupo g, string usuarios)
        {

            //PRIMERO CREO EL GRUPO.

            this.OpenConnection(); // Primero abro la conexión.

            SqlCommand cmd = new SqlCommand("Set_Grupo", cnn);
            cmd.CommandType = CommandType.StoredProcedure;
            //Añado los parámetros.
            cmd.Parameters.AddWithValue("@v_Nombre", g.Nombre); ;
            cmd.Parameters.AddWithValue("@v_Descripcion", g.Descripcion);
            cmd.Parameters.AddWithValue("@v_Administrador_id", g.Administrador_id);
            int id_grupo = 0;
            try
            {
                id_grupo = Convert.ToInt32(cmd.ExecuteScalar()); // OBTENGO LA ID DEL GRUPO AGREGADO.
            }
            catch (Exception e)
            {
                return e.ToString();
            }

            this.CloseConnection();

            //AHORA AGREGO A LOS USUARIOS AL GRUPO.

            this.OpenConnection();
            string[] id_usuarios = usuarios.Split(','); // VARIABLE SIMIL ARRAY CON LOS ID DE LOS USUARIOS.
            int k = 0;
            for(k = 0; k <id_usuarios.Length; k++)
            {
                SqlCommand _cmd = new SqlCommand("Set_Usuario_Grupo", cnn);
                _cmd.CommandType = CommandType.StoredProcedure;
                _cmd.Parameters.AddWithValue("@v_Grupo_id", id_grupo);
                _cmd.Parameters.AddWithValue("@v_Usuario_id", Convert.ToInt32(id_usuarios[k]));
                try
                {
                    int rowAffected = _cmd.ExecuteNonQuery(); // Ejecuto el SP.
                }
                catch (Exception e)
                {
                    return e.ToString();
                }
            }

            this.CloseConnection();
            return "Grupo creado exitosamente";
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
        //Método para agregar una sanción a un usuario determinado.
        public string Set_Sancion_Usuario(Usuario sancionador, Grupo g, Usuario sancionado, Sancion s)
        {

            //PRIMERO AGREGO LA SANCION.

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
            int id_sancion;
            try
            {
                id_sancion = Convert.ToInt32(cmd.ExecuteScalar()); // Ejecuto el SP y Obtengo el ID de la sanción.
                this.CloseConnection(); // Cierro la conexión.
            }
            catch (Exception e)
            {
                return e.ToString();
            }

            //ADEMAS DE AGREGAR LA SANCION, AGREGO UN VOTO POSITIVO.
            /* 0-> NEGATIVO.
             * 1-> POSITIVO.
            */

            this.OpenConnection(); // Primero abro la conexión.
            SqlCommand cmd_ = new SqlCommand("Set_Votos_Sanciones", cnn);
            cmd_.CommandType = CommandType.StoredProcedure;
            cmd_.Parameters.AddWithValue("@v_Sancion_id", id_sancion);
            cmd_.Parameters.AddWithValue("@v_Valor", 1); // Es POSITIVO.
            cmd_.Parameters.AddWithValue("@v_Usuario_id", sancionador.Id);
            try
            {
                cmd_.ExecuteNonQuery(); // Ejecuto el SP.
                this.CloseConnection(); // Cierro la conexión despues de votar.
            }
            catch (Exception e)
            {
                return e.ToString();
            }
            return "Sancion agregada a:" + sancionado._Usuario; // Retorno el mensaje.
        }
        //Método para agregar un voto positivo o negativo a una sanción. PASOS DEL METODO.
        /* 1) Primero se agrega un voto positivo o negativo a una determinada sanción.
         * 2) Después se cuenta la cantidad de votos que tiene la sanción votada.
         * 3) Después obtengo la cantidad de usuarios en el grupo de la sanción votada.
         * 4) Después evaluo si hay mas de 50% de votos positivos, se sanciona.
         */
        public string Set_Voto_Sancion(Usuario votante, Voto v, Sancion s)
        {
            //PRIMERO AGREGO UN VOTO POSITIVO O NEGATIVO A LA SANCION.
            /* 0-> NEGATIVO.
             * 1-> POSITIVO.
            */

            this.OpenConnection(); // Primero abro la conexión.
            SqlCommand cmd = new SqlCommand("Set_Votos_Sanciones", cnn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@v_Sancion_id", s.Id); ;
            cmd.Parameters.AddWithValue("@v_Valor", v.Valor); ;
            cmd.Parameters.AddWithValue("@v_Usuario_id", votante.Id);
            try
            {
                cmd.ExecuteNonQuery(); // Ejecuto el SP.
                this.CloseConnection(); // Cierro la conexión despues de votar.
            }
            catch (Exception e)
            {
                return e.ToString();
            }

            //VERIFICO DESPUES DE AGREGAR EL VOTO EL ESTADO DE LA SANCION.

            int cant_votos = 0;
            this.OpenConnection(); // Primero abro la conexión.
            SqlCommand cmd_ = new SqlCommand("Get_Votos_Sanciones", cnn); // Nombre del SP a Ejecutar.
            cmd_.Parameters.AddWithValue("@v_Sancion_id", s.Id);
            cmd_.CommandType = CommandType.StoredProcedure; // Tipo de comando.
            try
            {
                using (SqlDataReader reader = cmd_.ExecuteReader())
                {
                    if (reader.HasRows)
                    {
                        while (reader.Read()) // Mientras voy leyendo todos los resultados.
                        {
                            cant_votos = reader.GetInt32(0); // Obtengo la cantidad de votos positivos asociados a la sanción.
                        }
                    }
                }
                this.CloseConnection();
            }
            catch (Exception e)
            {
                return e.ToString();
            }

            //OBTENGO LA CANTIDAD DE USUARIOS EN EL GRUPO.

            int cant_usuarios = 0;
            this.OpenConnection(); // Primero abro la conexión.
            SqlCommand cmd__ = new SqlCommand("Get_Cant_Usuarios_Grupos", cnn); // Nombre del SP a Ejecutar.
            cmd__.Parameters.AddWithValue("@v_Grupo_id", s.Grupo_id);
            cmd__.CommandType = CommandType.StoredProcedure; // Tipo de comando.
            try
            {
                using (SqlDataReader reader = cmd__.ExecuteReader())
                {
                    if (reader.HasRows)
                    {
                        while (reader.Read()) // Mientras voy leyendo todos los resultados.
                        {
                            cant_usuarios = reader.GetInt32(0); // Obtengo de usuarios del grupo.
                        }
                    }
                }
                this.CloseConnection();
            }
            catch (Exception e)
            {
                return e.ToString();
            }

            //VERIFICO EL 50%

            float porcentaje = (cant_votos / cant_usuarios);
            //SI LA SANCION YA TIENE +50% SANCIONADO !
            if(porcentaje > 0.5)
            {
                this.OpenConnection(); // Primero abro la conexión.
                SqlCommand cmd___ = new SqlCommand("Update_Sancion", cnn);
                cmd___.CommandType = CommandType.StoredProcedure;
                cmd___.Parameters.AddWithValue("@v_Sancion_id", s.Id);
                try
                {
                    cmd___.ExecuteNonQuery(); // Ejecuto el SP.
                    this.CloseConnection(); // Cierro la conexión despues de votar.
                }
                catch (Exception e)
                {
                    return e.ToString();
                }
                return "Voto asignado, y la sanción ya cumple la cantidad de votos necesarios";
            }
            else
            {
                return "Voto asignado, pero todavía la sanción no cumple con el porcentaje necesario";
            }
        }
        //Método para determinada si cierta combinación de usuario - email es existente.
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
        //Método que devuelve la password(encriptada) de determinado usuario.
        public string Get_Password_Email(Usuario u)
        {
            this.OpenConnection(); // Primero abro la conexión.
            SqlCommand cmd = new SqlCommand("Get_Password_Email", cnn);
            cmd.CommandType = CommandType.StoredProcedure;

            //Añado los parámetros.
            cmd.Parameters.AddWithValue("@v_Usuario", u._Usuario);
            cmd.Parameters.AddWithValue("@v_Email", u.Email);
            try
            {
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.HasRows) // Si el select devuelve algo, es porque el usuario existe.
                    {
                        while (reader.Read()) // Mientras voy leyendo todos los resultados.
                        {
                            string password = reader.GetString(0); // Leo la password(encriptada).
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
        //Método que devuelve todas las sanciones de un grupo que un usuario no votó.
        public List<Sancion> Get_Sanciones_Activas_Grupos_Usuario(Grupo g, Usuario u)
        {
            List<Sancion> Sanciones = new List<Sancion>();
            this.OpenConnection(); // Primero abro la conexión.
            SqlCommand cmd = new SqlCommand("Get_Sanciones_Activas_Grupos_Usuario", cnn); // Nombre del SP a Ejecutar.
            cmd.Parameters.AddWithValue("@v_Grupo_id", g.Id); // Id del grupo.
            cmd.Parameters.AddWithValue("@v_Usuario_id", u.Id); // Id del usuario.
            //Las sanciones activas son entre ayer y hoy.
            cmd.Parameters.AddWithValue("@v_Hoy", DateTime.Now.AddDays(1));
            cmd.Parameters.AddWithValue("@v_Ayer", DateTime.Now.AddDays(-1));
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
        public Dictionary<string, int> Get_Cantidad_Sanciones_Usuarios_Grupo(Grupo g)
        {
            Dictionary<string, int> Sanciones = new Dictionary<string, int>();
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
                            Sanciones.Add(reader.GetString(0), reader.GetInt32(1));
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

        public string Delete_Grupo_Usuario(int grupo_id, int usuario_id)
        {
            this.OpenConnection(); // Primero abro la conexión.

            SqlCommand cmd = new SqlCommand("Delete_Grupo_Usuario", cnn);
            cmd.CommandType = CommandType.StoredProcedure;
            //Añado los parámetros.
            cmd.Parameters.AddWithValue("@v_Usuario_id", usuario_id); ;
            cmd.Parameters.AddWithValue("@v_Grupo_id", grupo_id);
            try
            {
                int rowAffected = cmd.ExecuteNonQuery(); // Ejecuto el SP.
                this.CloseConnection(); // Cierro la conexión.
                return "Grupo_usuario eliminado correctamente";
            }
            catch (Exception e)
            {
                return e.ToString();
            }
        }
    }
}
