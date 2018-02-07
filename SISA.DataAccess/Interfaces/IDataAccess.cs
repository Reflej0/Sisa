using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SISA.Common;

namespace SISA.DataAccess.Interfaces
{
    //Métodos para interactuar con la base de datos.
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
        //Método para listar los grupos de un usuario determinado.
        List<Grupo> Get_Grupos_Usuario(Usuario u);
        //Método para crear un nuevo grupo.
        string Set_Grupo(Grupo g);
        //Método para crear un nuevo usuario.
        string Set_Usuario(Usuario u);
        //Método para agregar un usuario a un grupo.
        string Set_Usuario_Grupo(Usuario u, Grupo g);
        //Método para agregar una sanción a un usuario.
        string Set_Sancion_Usuario(Usuario sancionador, Grupo g, Usuario sancionado, Sancion s);
        //Método para recuperar la contraseña
        string Get_Password_Email(Usuario u);
        //Método para obtener todas las sanciones activas de un determinado grupo.
        List<Sancion> Get_Sanciones_Activas_Grupos(Grupo g);
        //Método para obtener el grupo (por defecto) de un usuario.
        Grupo Get_Grupo_Determinado_Usuario(Usuario u);
        //Método para agregar un voto positivo o negativo a una sanción.
        string Set_Voto_Sancion(Usuario votante, Voto v, Sancion s);
    }
}
