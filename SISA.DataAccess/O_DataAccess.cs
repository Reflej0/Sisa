﻿using SISA.DataAccess.Interfaces;
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
        public bool Login(string usuario, string pass)
        {
            this.OpenConnection(); // Primero abro la conexión.
            SqlCommand cmd = new SqlCommand("Get_Usuario", cnn);
            cmd.CommandType = CommandType.StoredProcedure;

            //Añado los parámetros.
            cmd.Parameters.AddWithValue("@v_Usuario", usuario); ;
            cmd.Parameters.AddWithValue("@v_Password", pass);
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
            catch (Exception e)
            {
                return false;
            }
        }
    }
}
