using SISA.DataAccess;
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
        public List<Grupo> Get_Grupos_Usuario(int usuario_id)
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
        //Método para agregar una sanción a un usuario.
        public string Set_Sancion_Usuario(int usuario_sancionador_id, int grupo_id, int usuario_sancionado_id, string motivo)
        {
            Usuario usuario_sancionador = new Usuario();
            Grupo g = new Grupo();
            Usuario usuario_sancionado = new Usuario();
            Sancion s = new Sancion();
            usuario_sancionador.Id = usuario_sancionador_id;
            g.Id = grupo_id;
            usuario_sancionado.Id= usuario_sancionado_id;
            s.Motivo = motivo;
            s.Fecha_estado = DateTime.Now;
            return this.bd.Set_Sancion_Usuario(usuario_sancionador, g, usuario_sancionado, s);
        }
        //Método para obtener el password de un usuario en base a su usuario y mail.
        public string Get_Password_Email(string usuario, string email)
        {
            Usuario u = new Usuario();
            u._Usuario = usuario;
            u.Email = email;
            return this.bd.Get_Password_Email(u);
        }
        //Método para obtener las sanciones activas de un determinado grupo.
        public List<Sancion> Get_Sanciones_Activas_Grupos(int grupo_id)
        {
            Grupo g = new Grupo();
            g.Id = grupo_id;
            return this.bd.Get_Sanciones_Activas_Grupos(g);
        }
        //Método para obtener el grupo determinado de un usuario.
        public Grupo Get_Grupo_Determinado_Usuario(int usuario_id)
        {
            Usuario u = new Usuario();
            u.Id = usuario_id;
            return this.bd.Get_Grupo_Determinado_Usuario(u);
        }
        //Método para obtener la cantidad de sanciones por usuario de un determinado grupo.
        public Dictionary<string, int> Get_Cantidad_Sanciones_Usuarios_Grupo(int grupo_id)
        {
            Grupo g = new Grupo();
            g.Id = grupo_id;
            return this.bd.Get_Cantidad_Sanciones_Usuarios_Grupo(g);
        }
        //Método para obtener el nombre de un usuario.
        public String Get_Nombre_Usuario(int usuario_id)
        {
            Usuario u = new Usuario();
            u.Id = usuario_id;
            return this.bd.Get_Nombre_Usuario(u);
        }
        //Método para agregar un voto positivo o negativo a una sanción.
        public string Set_Voto_Sancion(int votante_id, int voto_valor, int sancion_id)
        {
            Usuario votante = new Usuario();
            votante.Id = votante_id;
            Voto v = new Voto();
            v.Valor = voto_valor;
            Sancion s = new Sancion();
            s.Id = sancion_id;
            return this.bd.Set_Voto_Sancion(votante, v, s);
        }
    }
}
