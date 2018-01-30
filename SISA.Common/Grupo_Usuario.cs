using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SISA.Common
{
    public class Grupo_Usuario
    {
        private int id;
        private int grupo_id;
        private int usuario_id;

        public int Id { get => id; set => id = value; }
        public int Grupo_id { get => grupo_id; set => grupo_id = value; }
        public int Usuario_id { get => usuario_id; set => usuario_id = value; }
    }
}
