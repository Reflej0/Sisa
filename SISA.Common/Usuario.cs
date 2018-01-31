using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SISA.Common
{
    public class Usuario
    {
        private int id;
        private string email;
        private string password;
        private string usuario;

        //Cuando busco objetos tipo Usuario de la BD tiene el ID.
        public Usuario(int id, string usuario, string password, string email)
        {
            this.id = id;
            this.usuario = usuario;
            this.password = password;
            this.email = email;
        }
        //Cuando manejo objetos tipo Usuario que todavía no tienen  el ID. 
        public Usuario(string usuario, string password, string email)
        {
            this.usuario = usuario;
            this.password = password;
            this.email = email;
        }
        //Por defecto.
        public Usuario()
        {
        }

        public int Id { get => id; set => id = value; }
        public string Email { get => email; set => email = value; }
        public string Password { get => password; set => password = value; }
        public string _Usuario { get => usuario; set => usuario = value; }
    }
}
