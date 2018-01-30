using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SISA.Common
{
    public class Sancion
    {
        private int id;
        private int grupo_id;
        private int usuario_creador_id;
        private int usuario_sancionado_id;
        private string motivo;
        private int estado;
        private DateTime fecha_estado;
        private int v1;
        private string v2;
        private string v3;
        private string v4;


        public Sancion(int id, int grupo_id, int usuario_creador_id, int usuario_sancionado_id, string motivo, int estado, DateTime fecha_estado)
        {
            this.id = id;
            this.grupo_id = grupo_id;
            this.usuario_creador_id = usuario_creador_id;
            this.usuario_sancionado_id = usuario_sancionado_id;
            this.motivo = motivo;
            this.estado = estado;
            this.fecha_estado = fecha_estado;
        }

        public int Id { get => id; set => id = value; }
        public int Grupo_id { get => grupo_id; set => grupo_id = value; }
        public int Usuario_creador_id { get => usuario_creador_id; set => usuario_creador_id = value; }
        public int Usuario_sancionado_id { get => usuario_sancionado_id; set => usuario_sancionado_id = value; }
        public string Motivo { get => motivo; set => motivo = value; }
        public int Estado { get => estado; set => estado = value; }
        public DateTime Fecha_estado { get => fecha_estado; set => fecha_estado = value; }
    }
}
