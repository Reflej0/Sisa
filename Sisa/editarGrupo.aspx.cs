using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using Business;
using SISA.Common;
using Newtonsoft.Json; //https://www.newtonsoft.com/json/help/html/SerializingCollections.htm


namespace Sisa
{
    public partial class EditarGrupo : System.Web.UI.Page
    {
        public string var_id_grupo;
        public Grupo grupoInicial;
        public string grupoString;
        public string integrOrig;
        public string usuarios;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Usuario_id"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            else
            {

                //obtengo el id de grupo desde la url:
                var_id_grupo = Request.QueryString["id"];

                O_Business objBusiness = new O_Business();

                int id_grupo = Int16.Parse(var_id_grupo);

                //consulto los valores del grupo:
                //grupoInicial = objBusiness.Get_Grupo(id_grupo);

                //grupoString = JsonConvert.SerializeObject(grupoInicial);
                grupoString = JsonConvert.SerializeObject(objBusiness.Get_Grupo(id_grupo));

                integrOrig = JsonConvert.SerializeObject(objBusiness.Get_Usuarios_Grupo(id_grupo));

                usuarios = JsonConvert.SerializeObject(objBusiness.Get_Usuarios());
            }
        }

    }
}