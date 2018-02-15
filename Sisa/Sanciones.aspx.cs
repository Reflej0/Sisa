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
        public List<Sancion> Sanciones { get { return sanciones; } }

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

                DateTime primerDia = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
                DateTime ultimoDia = new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.DaysInMonth(DateTime.Now.Year, DateTime.Now.Month));

                this.sanciones = objBusiness.Get_Sanciones_Grupos_Mes(Convert.ToInt32(Session["Usuario_id"]), primerDia, ultimoDia);
            }
        }
    }
}