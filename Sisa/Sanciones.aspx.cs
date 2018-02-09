using SISA.Common;
using Business;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Sisa
{
    public partial class Sanciones : System.Web.UI.Page
    {
        public List<Grupo> grupos;
        public List<List<string>> string_grupos;

        public List<Grupo> Grupos { get { return grupos; } }
        public List<List<string>> StringGrupos { get { return string_grupos; } }

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
                Response.Write("<div class='msg-welcome'><div class='navbar-brand text-welcome'> <i class='fas fa-user-circle'></i> " + Session["Nombre"] + "</div><p>");
                Response.Write(DateTime.Now.ToString() + "</p></div>");
                O_Business objBusiness = new O_Business(); // Inicializo el objeto global.
                this.grupos = objBusiness.Get_Grupos_Usuario(Convert.ToInt32(Session["Usuario_id"]));
                List<List<string>> lista_Grupos = new List<List<string>>();

                foreach (Grupo grupo in this.grupos)
                {
                    List<string> lista_Interna = new List<string>();
                    lista_Interna.Add(grupo.Id.ToString());
                    lista_Interna.Add(grupo.Nombre);
                    //lista_Interna.Add(grupo.Descripcion);
                    //lista_Interna.Add(grupo.Administrador_id.ToString());
                    lista_Grupos.Add(lista_Interna);
                }

                this.string_grupos = lista_Grupos;
            }

        }
    }
}
