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
    public partial class Votaciones : System.Web.UI.Page
    {
        public List<Sancion> sanciones;
        public List<List<string>> string_sanciones;
        public Dictionary<int, string> grupos;
        public Dictionary<int, string> Grupos { get { return grupos; } }
        public List<List<string>> StringSanciones { get { return string_sanciones; } }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Usuario_id"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            else
            {
                O_Business objBusiness = new O_Business(); // Inicializo el objeto global.
                List<Sancion> listado_sanciones = new List<Sancion>();
                Dictionary<int, string> dictgrupos = new Dictionary<int, string>();
                List<Grupo> grupos_relacionados = objBusiness.Get_Grupos_Usuario(Convert.ToInt32(Session["Usuario_id"]));
                foreach (var item in grupos_relacionados)
                {
                    int grupo_id = item.Id;

                    dictgrupos.Add(grupo_id, item.Nombre);
                    List<Sancion> sanciones_grupo = objBusiness.Get_Sanciones_Activas_Grupos_Usuario(grupo_id, Convert.ToInt32(Session["Usuario_id"]));
                    foreach (var sancion in sanciones_grupo)
                    {
                        listado_sanciones.Add(sancion);
                    }
                }

                this.sanciones = listado_sanciones;
                List<List<string>> lista_Sanciones = new List<List<string>>();

                foreach (Sancion sancion in this.sanciones)
                {
                    List<string> lista_Interna = new List<string>();
                    lista_Interna.Add(sancion.Grupo_id.ToString());
                    String nombre_usuario = objBusiness.Get_Nombre_Usuario(sancion.Usuario_sancionado_id);
                    lista_Interna.Add(nombre_usuario);
                    lista_Interna.Add(sancion.Motivo);
                    lista_Interna.Add(sancion.Id.ToString());
                    //Deberia traer texto
                    lista_Sanciones.Add(lista_Interna);
                }

                this.string_sanciones = lista_Sanciones;
                this.grupos = dictgrupos;
            }
        }
    }
}