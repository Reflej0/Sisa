using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SISA.Common
{
    public class Grupo
    {
        private int id;
        private string nombre;
        private string descripcion;
        private int administrador_id;

        public int Id { get => id; set => id = value; }
        public string Nombre { get => nombre; set => nombre = value; }
        public string Descripcion { get => descripcion; set => descripcion = value; }
        public int Administrador_id { get => administrador_id; set => administrador_id = value; }
    }
}
