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
        public string var_id_grupo;
        protected void Page_Load(object sender, EventArgs e)
        {
            //obtengo el id de grupo desde la url:
            var_id_grupo = Request.QueryString["id"];
        }

        //public string var_id_grupo { get; set; }
    }
}