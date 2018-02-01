using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using Business;
using SISA.Common;

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
     //Los WebMethods son los métodos los cuales recepcionan llamadas de AJAX.
     // AJAX -> WebMethod -> Business -> DataAccess.
    public class Service : System.Web.Services.WebService
    {
        public O_Business O_Business = null; // Creo un objeto global (en común a todos los webmethod).

        [WebMethod(CacheDuration = 1, BufferResponse = false, EnableSession = true)]
        //WebMethod para realizar el login.
        public bool Login(string user, string pass)
        {
            string e_pass = Seguridad.Encrypt(pass); // Encripto la password desde este punto antes de que viaje.
            bool resp = O_Business.Login(user, e_pass); // Guardo la respuesta en este caso para evaluar si debo invocar o no una variable de sesión.

            //Si devuelve true, es porque puede loguear.
            if (resp)
            {
                //Variables de Sesión https://msdn.microsoft.com/en-us/library/ms178581.aspx
                Session["Usuario_Logeado"] = user;
            }

            return resp;  // El string retornado indicará logeado o no logeado.
        }

        //WebMethod para crear un nuevo usuario.
        [WebMethod(CacheDuration = 1, BufferResponse = false)]
        public string Set_Usuario(string usuario, string password, string email)
        {
            string e_pass = Seguridad.Encrypt(password); // Encripto la password desde este punto antes de que viaje.
            bool resp = O_Business.Login(usuario, e_pass); // Guardo la respuesta en este caso para evaluar si debo invocar o no una variable de sesión

            O_Business = new O_Business(); // Inicializo el objeto global.
            return O_Business.Set_Usuario(usuario, e_pass, email); // Devuelvo el string del estado de la operación.
        }

        //WebMethod para crear un nuevo grupo.
        [WebMethod(CacheDuration = 1, BufferResponse = false)]
        public string Set_Grupo(string nombre, string descripcion, int administrador_id)
        {
            O_Business = new O_Business(); // Inicializo el objeto global.
            return O_Business.Set_Grupo(nombre, descripcion, administrador_id); // Devuelvo el OBJETO persona a la vista HTML.
        }

        [WebMethod(CacheDuration = 1, BufferResponse = false, EnableSession = true)]
        //WebMethod para realizar el login.
        public bool Get_Usuario(string user, string email)
        {
            bool resp = O_Business.Get_Usuario(user, email); // Guardo la respuesta en este caso para evaluar si debo invocar o no una variable de sesión.

            //Si devuelve true, es porque existe el usuario.
            return resp;
        }
    }
}
