using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using Business;

namespace Sisa.Services
{
    /// <summary>
    /// Descripción breve de Service
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
     [System.Web.Script.Services.ScriptService]
    public class Service : System.Web.Services.WebService
    {
        public O_Business O_Business = null; // Creo un objeto global (en común a todos los webmethod).
        [WebMethod(CacheDuration = 1, BufferResponse = false)]
        public string Login(string user, string pass)
        {
            
        }
        public string Set_Usuario(string usuario, string password, string email)
        {
            O_Business = new O_Business(); // Inicializo el objeto global.
            return O_Business.Set_Usuario(usuario, password, email); // Devuelvo el string del estado de la operación.

        }
        [WebMethod]
        public string Set_Grupo(string nombre, string descripcion, int administrador_id)
        {
            O_Business = new O_Business(); // Inicializo el objeto global.
            return O_Business.Set_Grupo(nombre, descripcion, administrador_id); // Devuelvo el OBJETO persona a la vista HTML.
        }
    }
}
