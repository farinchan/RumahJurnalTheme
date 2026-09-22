{**
 * plugins/themes/rumahJurnal/templates/frontend/components/footer.tpl
 *
 * Copyright (c) 2026 Rumah Jurnal
 *
 * Common site frontend footer for Rumah Jurnal theme.
 *}
	{* Close non-index page wrapper if open *}
	{if $requestedPage && $requestedPage != 'index'}
	</main>
	{/if}

	<!-- MAIN PORTAL FOOTER -->
	<footer class="bg-primary-900 text-slate-300 border-t-4 border-accent pt-14 pb-8 mt-auto">
		<div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
			<div class="grid grid-cols-1 md:grid-cols-4 gap-10 pb-12 border-b border-white/10">
				<!-- Col 1: About Institution -->
				<div class="md:col-span-2">
					<div class="flex items-center mb-4">
						{assign var="footerLogoUrl" value=$activeLogoUrl|default:$siteLogoUrl}
						{if $footerLogoUrl}
							<div class="bg-white/95 rounded-xl p-2.5 inline-block shadow-sm">
								<img src="{$footerLogoUrl}" 
									alt="{$activeSiteLogo.altText|default:$displayPageHeaderTitle|default:$siteTitle|default:'Rumah Jurnal'|escape}" 
									class="h-9 sm:h-10 w-auto object-contain">
							</div>
						{else}
							<span class="font-extrabold text-xl text-white tracking-tight">{$displayPageHeaderTitle|default:$siteTitle|default:"RUMAH JURNAL"}</span>
						{/if}
					</div>
					{if $pageFooter}
						<div class="text-xs text-slate-300 leading-relaxed max-w-lg mb-5 [&_p]:text-xs [&_p]:text-slate-300 [&_p]:leading-relaxed [&_p]:mb-2 [&_a]:text-accent hover:[&_a]:underline">
							{$pageFooter}
						</div>
					{else}
						<p class="text-xs text-slate-300 leading-relaxed max-w-lg mb-5">
							Rumah Jurnal adalah portal pengelolaan dan penerbitan berkala ilmiah terintegrasi yang memfasilitasi publikasi hasil riset dosen, peneliti, dan mahasiswa secara transparan, profesional, dan berstandar nasional maupun internasional.
						</p>
					{/if}
					<!-- <div class="flex items-center gap-3 text-sm">
						<a href="#" class="w-8 h-8 rounded-lg bg-white/10 hover:bg-accent hover:text-primary-900 flex items-center justify-center text-slate-200 transition">
							<i class="fa-brands fa-facebook-f"></i>
						</a>
						<a href="#" class="w-8 h-8 rounded-lg bg-white/10 hover:bg-accent hover:text-primary-900 flex items-center justify-center text-slate-200 transition">
							<i class="fa-brands fa-youtube"></i>
						</a>
						<a href="#" class="w-8 h-8 rounded-lg bg-white/10 hover:bg-accent hover:text-primary-900 flex items-center justify-center text-slate-200 transition">
							<i class="fa-brands fa-instagram"></i>
						</a>
						<a href="#" class="w-8 h-8 rounded-lg bg-white/10 hover:bg-accent hover:text-primary-900 flex items-center justify-center text-slate-200 transition">
							<i class="fa-solid fa-envelope"></i>
						</a>
					</div>  -->
				</div>

				<!-- Col 2: Quick Links -->
				<div>
					<h5 class="font-bold text-white text-sm uppercase tracking-wider mb-4 flex items-center gap-2">
						<span class="w-1.5 h-1.5 rounded-full bg-accent"></span>
						<span>Tautan Cepat</span>
					</h5>
					<ul class="space-y-2.5 text-xs text-slate-300">
						<li><a href="{url page="index" router=PKP\core\PKPApplication::ROUTE_PAGE}" class="hover:text-accent transition">Beranda Portal</a></li>
						<li><a href="{url page="index" router=PKP\core\PKPApplication::ROUTE_PAGE}#daftar-jurnal" class="hover:text-accent transition">Daftar Jurnal Terindeks</a></li>
						<li><a href="{url page="about" router=PKP\core\PKPApplication::ROUTE_PAGE}" class="hover:text-accent transition">Kebijakan Publikasi</a></li>
						<li><a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="login"}" class="hover:text-accent transition">Login Pengguna</a></li>
						<li><a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="user" op="register"}" class="hover:text-accent transition">Pendaftaran Akun Penulis</a></li>
					</ul>
				</div>

				<!-- Col 3: Contact Info -->
				<div>
					<h5 class="font-bold text-white text-sm uppercase tracking-wider mb-4 flex items-center gap-2">
						<span class="w-1.5 h-1.5 rounded-full bg-accent"></span>
						<span>Sekretariat</span>
					</h5>
					<ul class="space-y-3 text-xs text-slate-300">
						<li class="flex items-start gap-2.5">
							<i class="fa-solid fa-location-dot text-accent mt-1"></i>
							<span>Gedung Pusat Kajian & Rumah Jurnal, UIN Mahmud Yunus Batusangkar, Sumatera Barat, Indonesia</span>
						</li>
						<li class="flex items-center gap-2.5">
							<i class="fa-solid fa-envelope text-accent"></i>
							<span>rumahjurnal@uinmybatusangkar.ac.id</span>
						</li>
						<li class="flex items-center gap-2.5">
							<i class="fa-solid fa-globe text-accent"></i>
							<span>https://uinmybatusangkar.ac.id</span>
						</li>
					</ul>
				</div>
			</div>

			<!-- BOTTOM COPYRIGHT & OJS INFO -->
			<div class="pt-8 flex flex-col sm:flex-row items-center justify-between gap-4 text-xs text-slate-400">
				<div>
					&copy; {$smarty.now|date_format:"Y"} <strong>Rumah Jurnal</strong> {$siteTitle|default:"UIN Mahmud Yunus Batusangkar"}. All rights reserved.
				</div>
				<!-- <div class="flex items-center gap-2 text-slate-400">
					<span>Didukung oleh</span>
					<a href="https://pkp.sfu.ca/ojs/" target="_blank" rel="noopener" class="text-white hover:text-accent font-semibold transition">
						Open Journal Systems 3.5
					</a>
				</div>  -->
			</div>
		</div>
	</footer>

	<!-- BACK TO TOP BUTTON -->
	<button
		x-data="{ showTop: false }"
		@scroll.window="showTop = (window.pageYOffset > 400)"
		x-show="showTop"
		@click="window.scrollTo({ top: 0, behavior: 'smooth' })"
		x-transition
		class="fixed bottom-6 right-6 z-40 w-11 h-11 rounded-xl bg-primary text-white shadow-xl hover:bg-accent hover:text-primary-900 border border-accent/50 flex items-center justify-center transition duration-200"
		title="Kembali ke atas">
		<i class="fa-solid fa-arrow-up text-sm"></i>
	</button>

	{load_script context="frontend"}
	{call_hook name="Templates::Common::Footer::PageFooter"}

</body>
</html>
