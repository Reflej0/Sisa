using Business;
using SISA.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Sisa
{
    public partial class Sanciones1 : System.Web.UI.Page
    {
        List<Sancion> sanciones;
        public List<List<string>> stringSanciones;
        public Dictionary<int, string> grupos;
        public List<Sancion> Sanciones { get { return sanciones; } }
        public Dictionary<int, string> Grupos { get { return grupos; } }
        public List<List<string>> StringSanciones { get { return stringSanciones; } }

        protected void Page_Load(object sender, EventArgs e)
        {
            //NULL indica que es la primera vez que entro.
            //-1 o -2 indican que INTENTE entrar pero tengo creedenciales incorrectas.
            if (Session["Usuario_id"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            else
            {
                int usuario_id = Int32.Parse(Session["Usuario_id"].ToString());
                if (usuario_id < 0)
                {
                    Response.Redirect("Login.aspx");
                }
                O_Business objBusiness = new O_Business(); // Inicializo el objeto global.

                Dictionary<int, string> dicGrupos = new Dictionary<int, string>();
                List<Grupo> gruposRelacionados = objBusiness.Get_Grupos_Usuario(Convert.ToInt32(Session["Usuario_id"]));

                foreach (var item in gruposRelacionados)
                {
                    dicGrupos.Add(item.Id, item.Nombre);
                }

                DateTime primerDia = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
                DateTime ultimoDia = new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.DaysInMonth(DateTime.Now.Year, DateTime.Now.Month));
                this.sanciones = objBusiness.Get_Sanciones_Grupos_Mes(Convert.ToInt32(Session["Usuario_id"]), primerDia, ultimoDia);

                List<List<string>> listSanciones = new List<List<string>>();

                foreach (Sancion sancion in this.sanciones)
                {
                    List<string> lista_Interna = new List<string>();
                    lista_Interna.Add(sancion.Grupo_id.ToString());
                    String usuarioSancionador = objBusiness.Get_Nombre_Usuario(sancion.Usuario_creador_id);
                    lista_Interna.Add(usuarioSancionador);
                    String usuarioSancionado = objBusiness.Get_Nombre_Usuario(sancion.Usuario_sancionado_id);
                    lista_Interna.Add(usuarioSancionado);
                    lista_Interna.Add(sancion.Motivo);
                    lista_Interna.Add(sancion.Estado.ToString());
                    lista_Interna.Add(sancion.Fecha_estado.ToString());
                    
                    listSanciones.Add(lista_Interna);
                }

                this.stringSanciones = listSanciones;
                this.grupos = dicGrupos;
            }
        }
    }
}