using SISA.DataAccess;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
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
        public string Set_Usuario(string usuario, string password, string email)
        {
            Usuario u = new Usuario(usuario, password, email);
            string respuesta = this.bd.Set_Usuario(u);
            return respuesta;
        }
        public string Set_Grupo(string nombre, string descripcion, int administrador_id)
        {
            Grupo g = new Grupo(nombre, descripcion, administrador_id);
            string respuesta = this.bd.Set_Grupo(g);
            return respuesta;
        }

    }
}
