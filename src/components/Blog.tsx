// src/components/Blog.tsx
import Link from 'next/link';

export default function Blog() {
  const posts = [
    {
      id: 1,
      title: "Nos bastidores do novo clipe",
      excerpt: "Confira os detalhes da produção do mais novo lançamento de João Guilherme",
      image: "/images/blog1.jpg",
      date: "15 de Junho, 2023",
      author: "Equipe João Guilherme"
    },
    {
      id: 2,
      title: "A jornada musical: dos primórdios ao sucesso",
      excerpt: "Como João Guilherme construiu sua carreira e se tornou uma das principais vozes do sertanejo pop",
      image: "/images/blog2.jpg",
      date: "02 de Junho, 2023",
      author: "Redação"
    },
    {
      id: 3,
      title: "5 curiosidades sobre João Guilherme",
      excerpt: "Coisas que você provavelmente não sabia sobre o cantor e compositor",
      image: "/images/blog3.jpg",
      date: "20 de Maio, 2023",
      author: "Redação"
    }
  ];

  return (
    <section className="py-20 bg-black-primary">
      <div className="container mx-auto px-4">
        <div className="text-center mb-16">
          <h2 className="text-3xl md:text-4xl font-bold text-white mb-4">Blog</h2>
          <p className="text-gray-400 max-w-2xl mx-auto">Acompanhe as novidades e os bastidores da carreira de João Guilherme</p>
        </div>
        
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
          {posts.map((post) => (
            <div key={post.id} className="bg-gray-primary rounded-2xl overflow-hidden shadow-lg hover:shadow-xl transition-shadow">
              <div className="h-48 overflow-hidden">
                <img 
                  src={post.image} 
                  alt={post.title} 
                  className="w-full h-full object-cover hover:scale-105 transition-transform duration-500"
                />
              </div>
              <div className="p-6">
                <div className="text-gray-500 text-sm mb-2">{post.date} • {post.author}</div>
                <h3 className="text-xl font-semibold text-white mb-3">{post.title}</h3>
                <p className="text-gray-400 mb-4">{post.excerpt}</p>
                <Link 
                  href={`/blog/${post.id}`}
                  className="text-blue-light hover:text-blue-400 font-medium flex items-center"
                >
                  Ler mais
                  <svg xmlns="http://www.w3.org/2000/svg" className="h-5 w-5 ml-1" viewBox="0 0 20 20" fill="currentColor">
                    <path fillRule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clipRule="evenodd" />
                  </svg>
                </Link>
              </div>
            </div>
          ))}
        </div>
        
        <div className="text-center mt-12">
          <Link 
            href="/blog"
            className="inline-flex items-center bg-blue-light text-white px-6 py-3 rounded-full font-semibold hover:bg-blue-600 transition-colors"
          >
            Explorar Bastidores
            <svg xmlns="http://www.w3.org/2000/svg" className="h-5 w-5 ml-2" viewBox="0 0 20 20" fill="currentColor">
              <path fillRule="evenodd" d="M10.293 5.293a1 1 0 011.414 0l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414-1.414L12.586 11H5a1 1 0 110-2h7.586l-2.293-2.293a1 1 0 010-1.414z" clipRule="evenodd" />
            </svg>
          </Link>
        </div>
      </div>
    </section>
  );
}
