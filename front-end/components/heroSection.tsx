export const HeroSection = () => {
  return (
    <section className="relative bg-[url(https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=875&q=80)] bg-cover bg-center bg-no-repeat">
      <div className="absolute inset-0 bg-primary/50 sm:bg-transparent sm:bg-gradient-to-r sm:from-white/40 sm:to-white/5"></div>

      <div className="relative mx-auto max-w-screen-xl px-4 py-32 sm:px-6 lg:flex lg:h-screen lg:items-start lg:px-8">
        <div className="max-w-xl text-center sm:text-left">
          <h1 className="text-3xl font-extrabold sm:text-5xl">
            Buy Real Estate
            <strong className="block font-extrabold text-secondary">
              with Crypto
            </strong>
          </h1>

          <p className="mt-4 max-w-lg sm:text-xl sm:leading-relaxed font-inter">
            Invest in Real Estate
          </p>

          <div className="mt-8 flex flex-wrap gap-4 text-center">
            <a
              href="#"
              className="block w-full rounded-full bg-secondary px-10 py-3 text-sm font-medium text-primary shadow hover:opacity-75 focus:outline-none sm:w-auto"
            >
              Start Your Search
            </a>
          </div>
        </div>
      </div>
    </section>
  );
};
