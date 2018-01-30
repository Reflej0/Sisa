using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SISA.Common;

namespace SISA.DataAccess.Interfaces
{
    public interface IDataAccess
    {
        //Métodos de la interfaz, a heredar por la clase DataAccess.
        //String de conexión.
        string ConnectionString { get; set; }
        //Método para abrir la conexión a la BD.
        void OpenConnection();
        //Método para cerrar la conexión a la BD.
        void CloseConnection();
        //Método para obtener el listado de todos los grupos.
        List<Grupo> Get_Grupos();
        //Método para obtener el listado de todos los usuarios de un grupo.
        List<Usuario> Get_Usuarios_Grupo(Grupo g);
        //Método para obtener el listado de todas las sanciones de un usuario.
        List<Sancion> Get_Sancion_Usuario(Usuario u);
        //Método para obtener el administrador de un determinado grupo.
        Usuario Get_Administrador_Grupo(Grupo g);
    }
}
