using Business;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Sisa
{
	public partial class detalleGrupo : System.Web.UI.Page
	{
        public Dictionary<string, int> sanciones;
        public Dictionary<string, int> Sanciones { get { return sanciones; } }

        protected void Page_Load(object sender, EventArgs e)
		{
            if (Session["Usuario_id"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            else
            {
                Response.Write("<div class='msg-grupo'>Bienvenido, " + Session["Nombre"] + "<br/>");
                Response.Write(DateTime.Now.ToString() + "</div>");

                O_Business objBusiness = new O_Business(); // Inicializo el objeto global.
                this.sanciones = objBusiness.Get_Cantidad_Sanciones_Usuarios_Grupo(1);
            }
        }
	}
}