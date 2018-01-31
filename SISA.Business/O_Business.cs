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
        //Método que es llamado desde el WebMethod, el string password ya esta encriptado.
        public string Set_Usuario(string usuario, string password, string email)
        {
            Usuario u = new Usuario(usuario, password, email);
            string respuesta = this.bd.Set_Usuario(u);
            return respuesta;
        }
        //Método que es llamado desde el WebMethod.
        public string Set_Grupo(string nombre, string descripcion, int administrador_id)
        {
            Grupo g = new Grupo(nombre, descripcion, administrador_id);
            string respuesta = this.bd.Set_Grupo(g);
            return respuesta;
        }
        //Método estático ya que en el momento del login todavía no hay una instancia de Business, DataAccess, etc.
        public static bool Login(string user, string pass)
        {
            //Instancio un objeto de DataAccess solo para el login, al hacer el return ya no es posible acceder mas a el.
            O_DataAccess temp = new O_DataAccess("workstation id = reflejox.mssql.somee.com; packet size = 4096; user id = Reflejo_SQLLogin_1; pwd = ta7b53bvam; data source = reflejox.mssql.somee.com; persist security info = False; initial catalog = reflejox");
            return temp.Login(user, pass);
        }

    }
}
