﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SISA.Common
{
    class Usuario
    {
        private int id;
        private string email;
        private string password;
        private string usuario;

        public int Id { get => id; set => id = value; }
        public string Email { get => email; set => email = value; }
        public string Password { get => password; set => password = value; }
        public string _Usuario { get => usuario; set => usuario = value; }
    }
}
