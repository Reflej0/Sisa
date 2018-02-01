﻿using SISA.DataAccess;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Threading.Tasks;
using SISA.Common;

//Esta capa sería el controlador de MVC, a Business le llegan los datos de UI.
namespace Business
{
    public class O_Business
    {
        //Cada objeto de negocio tiene su propio acceso a la bd.
        private O_DataAccess bd = null;
        //Constructor de Business.
        public O_Business()
        {
            bd = new O_DataAccess("workstation id = reflejox.mssql.somee.com; packet size = 4096; user id = Reflejo_SQLLogin_1; pwd = ta7b53bvam; data source = reflejox.mssql.somee.com; persist security info = False; initial catalog = reflejox");
        }
        //Método para crear un nuevo usuario.
        public string Set_Usuario(string usuario, string password, string email)
        {
            Usuario u = new Usuario(usuario, password, email);
            string respuesta = this.bd.Set_Usuario(u);
            return respuesta;
        }
        //Método para crear un nuevo grupo.
        public string Set_Grupo(string nombre, string descripcion, int administrador_id)
        {
            Grupo g = new Grupo(nombre, descripcion, administrador_id);
            string respuesta = this.bd.Set_Grupo(g);
            return respuesta;
        }
        //Método encargado de gestionar el login.
        public static int Login(string user, string pass)
        {
            //Instancio un objeto de DataAccess solo para el login, al hacer el return ya no es posible acceder mas a el.
            O_DataAccess temp = new O_DataAccess("workstation id = reflejox.mssql.somee.com; packet size = 4096; user id = Reflejo_SQLLogin_1; pwd = ta7b53bvam; data source = reflejox.mssql.somee.com; persist security info = False; initial catalog = reflejox");
            return temp.Login(user, pass);
        }
        //Método que es llamado desde el WebMethod y devuelve una lista de objetos tipos grupos, como se va a manejar en la vista!?
        public List<Grupo> Get_Grupos_Usuarios(int usuario_id)
        {
            Usuario u = new Usuario(); // Creo un objeto usuario.
            u.Id = usuario_id; // Le asigno solamente el id.
            List<Grupo> grupos = this.bd.Get_Grupos_Usuario(u); // Llamo al método que se encarga de devolverme los grupos a los cuales el usuario esta asignado.
            return grupos; // Retorno.
        }

        public bool Get_Usuario(string user, string email)
        {
            //Instancio un objeto de DataAccess solo para el login, al hacer el return ya no es posible acceder mas a el.
            O_DataAccess temp = new O_DataAccess("workstation id = reflejox.mssql.somee.com; packet size = 4096; user id = Reflejo_SQLLogin_1; pwd = ta7b53bvam; data source = reflejox.mssql.somee.com; persist security info = False; initial catalog = reflejox");
            return temp.Get_Usuario(user, email);
        }
        //Método para obtener los usuarios de un grupo, en base al id del grupo.
        public List<Usuario> Get_Usuarios_Grupo(int grupo_id)
        {
            Grupo g = new Grupo(); // Creo un objeto grupo.
            g.Id = grupo_id; // Le asigno solamente el id.
            List<Usuario> Usuarios = this.bd.Get_Usuarios_Grupo(g);
            return Usuarios;
        }
        //Método para obtener el listado de sanciones de un usuario, en base a su id.
        public List<Sancion> Get_Sancion_Usuario(int usuario_id)
        {
            Usuario u = new Usuario(); // Creo un objeto usuario.
            u.Id = usuario_id; // Le asigno solamente el id.
            List<Sancion> Sanciones = this.bd.Get_Sancion_Usuario(u);
            return Sanciones;
        }
        //Método para obtener el administrador de un determinado grupo.
        public Usuario Get_Administrador_Grupo(int grupo_id)
        {
            Grupo g = new Grupo(); // Creo un objeto grupo.
            g.Id = grupo_id; // Le asigno solamente el id.
            Usuario administrador = this.bd.Get_Administrador_Grupo(g);
            return administrador;
        }
        //Método para agregar un usuario a un determinado grupo.
        public string Set_Usuario_Grupo(int usuario_id, int grupo_id)
        {
            Usuario u = new Usuario(); // Creo un objeto usuario.
            u.Id = usuario_id; // Le asigno solamente el id.
            Grupo g = new Grupo(); // Creo un objeto grupo.
            g.Id = grupo_id; // Le asigno solamente el id.
            return this.bd.Set_Usuario_Grupo(u, g);
        }
    }
}
