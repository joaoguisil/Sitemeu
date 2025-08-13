// src/components/Patrocinadores.tsx
import Link from 'next/link';

export default function Patrocinadores() {
  const sponsors = [
    { id: 1, name: "Empresa A", logo: "/images/sponsor1.png" },
    { id: 2, name: "Empresa B", logo: "/images/sponsor2.png" },
    { id: 3, name: "Empresa C", logo: "/images/sponsor3.png" },
    { id: 4, name: "Empresa D", logo: "/images/sponsor4.png" },
    { id: 5, name: "Empresa E", logo: "/images/sponsor5.png" },
    { id: 6, name: "Empresa F", logo: "/images/sponsor6.png" }
  ];

  return (
    <section className="py-20 bg-gray-primary">
      <div className="container mx-auto px-4">
        <div className="text-center mb-16">
          <h2 className="text-3xl md:text-4xl font-bold text-white mb-4">Parceiros</h2>
          <p className="text-gray-400 max-w-2xl mx-auto">Fortaleça sua marca ao lado de João Guilherme</p>
        </div>
        
        <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-6 gap-8 mb-12">
          {sponsors.map((sponsor) => (
            <div key={sponsor.id} className="flex items-center justify-center bg-black-primary rounded-xl p-6 hover:bg-blue-dark transition-colors">
              <img 
                src={sponsor.logo} 
                alt={sponsor.name} 
                className="max-h-16 max-w-full filter grayscale hover:grayscale-0 transition-all"
              />
            </div>
          ))}
        </div>
        
        <div className="text-center">
          <Link 
            href="/seja-parceiro"
            className="inline-flex items-center bg-blue-light text-white px-6 py-3 rounded-full font-semibold hover:bg-blue-600 transition-colors"
          >
            <span className="mr-2">💼</span> Seja um Parceiro
          </Link>
        </div>
      </div>
    </section>
  );
}
