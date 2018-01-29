using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SISA.Common
{
    class Sancion
    {
        private int id;
        private int grupo_id;
        private int usuario_creador_id;
        private int usuario_sancionado_id;
        private string motivo;
        private int estado;
        private DateTime fecha_estado;

        public int Id { get => id; set => id = value; }
        public int Grupo_id { get => grupo_id; set => grupo_id = value; }
        public int Usuario_creador_id { get => usuario_creador_id; set => usuario_creador_id = value; }
        public int Usuario_sancionado_id { get => usuario_sancionado_id; set => usuario_sancionado_id = value; }
        public string Motivo { get => motivo; set => motivo = value; }
        public int Estado { get => estado; set => estado = value; }
        public DateTime Fecha_estado { get => fecha_estado; set => fecha_estado = value; }
    }
}
