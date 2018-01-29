using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SISA.Common
{
    class Voto
    {
        private int id;
        private int usuario_id;
        private int sancion_id;
        private int valor;

        public int Id { get => id; set => id = value; }
        public int Usuario_id { get => usuario_id; set => usuario_id = value; }
        public int Sancion_id { get => sancion_id; set => sancion_id = value; }
        public int Valor { get => valor; set => valor = value; }
    }
}
