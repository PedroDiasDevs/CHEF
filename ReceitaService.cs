using CHEF.Data;
using CHEF.Models;
using System.Collections.Generic;
using System.Threading.Tasks;
public class ReceitaService
{
    private readonly ChefDbContext _context;
    public ReceitaService(ChefDbContext context)
    {
        _context = context;
    }
    public async Task<List<Receita>> GetAllReceitasAsync()
    {
        return await _context.Receitas.Include(r => r.Ingredientes).Include(r => r.Utensilios).ToListAsync();
    }
    public async Task AddReceitaAsync(Receita receita)
    {
        _context.Receitas.Add(receita);
        await _context.SaveChangesAsync();
    }
}