using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using Business;
using SISA.Common;
using Newtonsoft.Json; //https://www.newtonsoft.com/json/help/html/SerializingCollections.htm
using System.Net.Mail;
using System.Net;

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
        public int Login(string user, string pass)
        {
            string e_pass = Seguridad.Encrypt(pass); // Encripto la password desde este punto antes de que viaje.
            int resp = O_Business.Login(user, e_pass); // Guardo la respuesta en este caso para evaluar si debo invocar o no una variable de sesión.

            //Si devuelve mayor a 0 entonces logeo correctamente.
            if (resp > 0)
            {
                //Variables de Sesión https://msdn.microsoft.com/en-us/library/ms178581.aspx
                Session["Usuario_id"] = resp;
            }

            return resp;  // El número retornado indicará logeado o no logeado.
        }
        [WebMethod(CacheDuration = 1, BufferResponse = false, EnableSession = true)]
        //Método para deslogear.
        public void Logout()
        {
            Session["Usuario_id"] = null;
        }

        //WebMethod para crear un nuevo usuario.
        [WebMethod(CacheDuration = 1, BufferResponse = false)]
        public string Set_Usuario(string usuario, string password, string email)
        {
            string e_pass = Seguridad.Encrypt(password); // Encripto la password desde este punto antes de que viaje.
            int resp = O_Business.Login(usuario, e_pass); // Guardo la respuesta en este caso para evaluar si debo invocar o no una variable de sesión

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
        [WebMethod(CacheDuration = 1, BufferResponse = false, EnableSession = true)]
        //WebMethod para recuperar la contraseña.
        public string Recuperar_Contrasena(string user, string email)
        {
            O_Business = new O_Business();
            bool resp = O_Business.Get_Usuario(user, email); // Guardo la respuesta en este caso para evaluar si debo invocar o no una variable de sesión.
            if (resp)
            {
                String nuevaContrasena = Seguridad.Decrypt(O_Business.Get_Password_Email(user, email));
                //Armo el mail
                MailMessage o = new MailMessage("sisa.reportes@gmail.com", email, "Recuperar Contraseña", "Tu contraseña es: " + nuevaContrasena);
                //Credenciales
                NetworkCredential netCred = new NetworkCredential("sisa.reportes@gmail.com", "1823deltaepsilonAlfa");
                SmtpClient smtpobj = new SmtpClient("smtp.gmail.com", 587);
                smtpobj.EnableSsl = true;
                smtpobj.Credentials = netCred;
                smtpobj.Send(o);
                return "Revisa tu correo";
            }
            else
            {
                return "No existe!";
            }
        }
        [WebMethod(CacheDuration = 1, BufferResponse = false, EnableSession = true)]
        //Este método no recibe usuario_id porque ya esta en Session. Recibe el Usuario_id y muestra los grupos asociados.
        public string Get_Grupos_Usuarios()
        {
            O_Business = new O_Business(); // Inicializo el objeto global.
            //Devuelve un string que es un JSON que Serializa el List<>, la cuestión es que ANDA.
            //https://www.newtonsoft.com/json/help/html/SerializingCollections.htm
            return JsonConvert.SerializeObject(O_Business.Get_Grupos_Usuario(Convert.ToInt32(Session["Usuario_id"])), Formatting.Indented);
        }
        [WebMethod(CacheDuration = 1, BufferResponse = false, EnableSession = true)]
        //Este método no recibe usuario_id porque ya esta en Session. Recibe el Usuario_id y muestra las sanciones.
        public string Get_Sancion_Usuario()
        {
            O_Business = new O_Business(); // Inicializo el objeto global.
            return JsonConvert.SerializeObject(O_Business.Get_Sancion_Usuario(Convert.ToInt32(Session["Usuario_id"])), Formatting.Indented);
        }
        [WebMethod(CacheDuration = 1, BufferResponse = false, EnableSession = true)]
        //Este método recibe llamadas de AJAX cada 1 segundo.
        public string Get_Sanciones_Activas_Grupos(int grupo_id)
        {
            O_Business = new O_Business(); // Inicializo el objeto global.
            return JsonConvert.SerializeObject(O_Business.Get_Sanciones_Activas_Grupos(grupo_id), Formatting.Indented);
        }
        [WebMethod(CacheDuration = 1, BufferResponse = false, EnableSession = true)]
        //Método para obtener el grupo (por defecto de un usuario).
        public int Get_Grupo_Determinado_Usuario()
        {
            O_Business = new O_Business(); // Inicializo el objeto global.
            return O_Business.Get_Grupo_Determinado_Usuario(Convert.ToInt32(Session["Usuario_id"])).Id;
        }
        [WebMethod(CacheDuration = 1, BufferResponse = false, EnableSession = true)]
        //Este método recibe grupo id y trae los usuarios vinculados
        public List<Usuario> Get_Usuarios_Grupos(int grupo_id)
        {
            O_Business = new O_Business(); // Inicializo el objeto global.
            //Devuelve un string que es un JSON que Serializa el List<>, la cuestión es que ANDA.
            //https://www.newtonsoft.com/json/help/html/SerializingCollections.htm
            return O_Business.Get_Usuarios_Grupo(grupo_id);
        }
        //WebMethod para crear una nueva sancion
        [WebMethod(CacheDuration = 1, BufferResponse = false)]
        public int Set_Sancion_Usuario(int grupo_id, int sancionado_id, int sancionador_id, string motivo)
        {
            O_Business = new O_Business(); // Inicializo el objeto global.
            Grupo grupoSancionador = O_Business.Get_Grupo_Determinado_Usuario(sancionador_id);
            Grupo grupoSancionado = O_Business.Get_Grupo_Determinado_Usuario(sancionado_id);
            int flagError = 0;
            if (grupoSancionado.Id.Equals(grupo_id) && grupoSancionador.Id.Equals(grupo_id))
            {
                //Faltan validaiciones de motivo?
                String sancion = O_Business.Set_Sancion_Usuario(sancionador_id, grupo_id, sancionado_id, motivo);

                if (sancion.Length.Equals(0))
                {
                    flagError = 1;
                }
            }
            else
            {
                flagError = 1;
            }

            return flagError;
        }
    }
}
