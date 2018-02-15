using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Sisa
{
    public partial class editarGrupo : System.Web.UI.Page
    {
        string id_grupo;
        protected void Page_Load(object sender, EventArgs e)
        {
            //obtengo el id de grupo desde la url:
            id_grupo = Request.QueryString["id"];
        }

        public string Id_grupo { get; set; }
    }
}