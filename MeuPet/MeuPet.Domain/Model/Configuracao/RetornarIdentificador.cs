using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MeuPet.Domain.Model.Configuracao
{
    public class RetornarIdentificador
    {
        [Key]
        public int Id { get; set; }
    }
}
