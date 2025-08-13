// src/components/FanClub.tsx
import { useState } from 'react';

export default function FanClub() {
  const [email, setEmail] = useState('');
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [submitted, setSubmitted] = useState(false);

  const handleSubmit = async (e) => {
    e.preventDefault();
    setIsSubmitting(true);
    
    // Simulate API call to Mailchimp
    setTimeout(() => {
      setIsSubmitting(false);
      setSubmitted(true);
      setEmail('');
      
      // Reset success message after 5 seconds
      setTimeout(() => setSubmitted(false), 5000);
    }, 1500);
  };

  return (
    <section className="py-20 bg-gradient-to-r from-blue-dark to-black-primary">
      <div className="container mx-auto px-4">
        <div className="max-w-4xl mx-auto">
          <div className="flex flex-col md:flex-row items-center">
            <div className="md:w-1/2 mb-10 md:mb-0">
              <div className="relative">
                <div className="absolute -inset-4 bg-blue-light rounded-full opacity-20 blur-xl"></div>
                <img 
                  src="/images/fan-club.jpg" 
                  alt="Fã Clube VIP João Guilherme" 
                  className="relative rounded-2xl shadow-2xl w-full"
                />
              </div>
            </div>
            
            <div className="md:w-1/2 md:pl-12">
              <div className="bg-black-primary bg-opacity-70 backdrop-blur-sm rounded-2xl p-8 shadow-xl">
                <h2 className="text-3xl font-bold text-white mb-4">Fã Clube VIP</h2>
                <p className="text-gray-300 mb-6">Seja parte do time que está mais perto de João Guilherme.</p>
                
                <div className="space-y-4 mb-8">
                  <div className="flex items-start">
                    <div className="flex-shrink-0 mt-1">
                      <div className="w-6 h-6 rounded-full bg-blue-light flex items-center justify-center">
                        <svg xmlns="http://www.w3.org/2000/svg" className="h-4 w-4 text-black-primary" viewBox="0 0 20 20" fill="currentColor">
                          <path fillRule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clipRule="evenodd" />
                        </svg>
                      </div>
                    </div>
                    <div className="ml-3">
                      <h3 className="text-white font-medium">Acesso antecipado</h3>
                      <p className="text-gray-400 text-sm">Compre ingressos antes do público geral</p>
                    </div>
                  </div>
                  
                  <div className="flex items-start">
                    <div className="flex-shrink-0 mt-1">
                      <div className="w-6 h-6 rounded-full bg-blue-light flex items-center justify-center">
                        <svg xmlns="http://www.w3.org/2000/svg" className="h-4 w-4 text-black-primary" viewBox="0 0 20 20" fill="currentColor">
                          <path fillRule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clipRule="evenodd" />
                        </svg>
                      </div>
                    </div>
                    <div className="ml-3">
                      <h3 className="text-white font-medium">Brindes exclusivos</h3>
                      <p className="text-gray-400 text-sm">Receba produtos personalizados e edições limitadas</p>
                    </div>
                  </div>
                  
                  <div className="flex items-start">
                    <div className="flex-shrink-0 mt-1">
                      <div className="w-6 h-6 rounded-full bg-blue-light flex items-center justify-center">
                        <svg xmlns="http://www.w3.org/2000/svg" className="h-4 w-4 text-black-primary" viewBox="0 0 20 20" fill="currentColor">
                          <path fillRule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clipRule="evenodd" />
                        </svg>
                      </div>
                    </div>
                    <div className="ml-3">
                      <h3 className="text-white font-medium">Conteúdo exclusivo</h3>
                      <p className="text-gray-400 text-sm">Acesse bastidores, entrevistas e vídeos exclusivos</p>
                    </div>
                  </div>
                </div>
                
                {submitted ? (
                  <div className="bg-green-900 bg-opacity-30 border border-green-500 rounded-lg p-4 text-center">
                    <div className="text-green-400 font-medium">Inscrição realizada com sucesso!</div>
                    <p className="text-green-300 text-sm mt-1">Verifique seu e-mail para confirmar.</p>
                  </div>
                ) : (
                  <form onSubmit={handleSubmit} className="space-y-4">
                    <div>
                      <input
                        type="email"
                        value={email}
                        onChange={(e) => setEmail(e.target.value)}
                        placeholder="Seu melhor e-mail"
                        required
                        className="w-full bg-gray-primary text-white rounded-lg px-4 py-3 focus:outline-none focus:ring-2 focus:ring-blue-light"
                      />
                    </div>
                    <button
                      type="submit"
                      disabled={isSubmitting}
                      className="w-full bg-blue-light text-white px-6 py-3 rounded-lg font-semibold hover:bg-blue-600 transition-colors flex items-center justify-center disabled:opacity-70"
                    >
                      {isSubmitting ? (
                        <>
                          <svg className="animate-spin -ml-1 mr-3 h-5 w-5 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                            <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4"></circle>
                            <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                          </svg>
                          Processando...
                        </>
                      ) : (
                        <>
                          <span className="mr-2">🎁</span> Entrar para o Fã Clube VIP
                        </>
                      )}
                    </button>
                    <p className="text-gray-500 text-sm text-center">
                      Seja VIP e receba conteúdos exclusivos.
                    </p>
                  </form>
                )}
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
}
