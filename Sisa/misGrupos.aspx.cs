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
    public partial class misGrupos : System.Web.UI.Page
    {
        public List<Grupo> grupos;
        public List<String> nombresGrupos;
        public List<Grupo> Grupos { get { return grupos; } }
        public List<String> NombresGrupos { get { return nombresGrupos; } }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Usuario_id"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            else
            {
                O_Business objBusiness = new O_Business(); // Inicializo el objeto global.
                this.grupos = objBusiness.Get_Grupos_Usuario(Convert.ToInt32(Session["Usuario_id"]));

                List<String> misGrupos = new List<String>();

                foreach (Grupo grupo in this.grupos)
                {
                    misGrupos.Add(grupo.Nombre);
                }

                this.nombresGrupos = misGrupos;
            }
        }
    }
}