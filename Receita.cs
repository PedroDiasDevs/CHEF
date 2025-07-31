namespace CHEF.Models
{
    public class Receita
    {
        public int Id { get; set; }
        public string Nome { get; set; }
        public List<Ingrediente> Ingredientes { get; set; }
        public List<Utensilio> Utensilios { get; set; }
        public int TempoPreparacao { get; set; }
        public string ModoPreparo { get; set; }
    }
}
