{**
 * plugins/themes/rumahJurnal/templates/frontend/pages/userLogin.tpl
 *
 * Copyright (c) 2026 Fajri Rinaldi Chan
 * Theme Support: https://nagastra.org
 *
 * Modern user login page for Rumah Jurnal theme (Focused Centered Card).
 *}
{include file="frontend/components/header.tpl" pageTitle="user.login"}

<div class="py-6 sm:py-10 max-w-xl mx-auto">
	<!-- BREADCRUMBS -->
	<nav class="flex items-center gap-2 text-xs text-slate-500 mb-8" aria-label="Breadcrumb">
		<a href="{url page="index" router=PKP\core\PKPApplication::ROUTE_PAGE}" class="hover:text-primary transition flex items-center gap-1.5 font-medium">
			<i class="fa-solid fa-house text-slate-400"></i>
			<span>{translate key="common.homepageNavigationLabel"}</span>
		</a>
		<i class="fa-solid fa-chevron-right text-[10px] text-slate-400"></i>
		<span class="text-slate-800 font-semibold">{translate key="user.login"}</span>
	</nav>

	<!-- AUTHENTICATION CARD -->
	<div class="bg-white rounded-2xl shadow-xl shadow-slate-200/70 border border-slate-200/90 relative overflow-hidden">
		<!-- Top Accent Gradient Line -->
		<div class="h-1.5 w-full bg-gradient-to-r from-primary via-accent to-primary-light"></div>

		<div class="p-6 sm:p-10">
			<!-- Header -->
			<div class="flex items-center gap-3.5 mb-6">
				<div class="w-12 h-12 rounded-xl bg-primary-50 text-primary flex items-center justify-center text-xl font-bold flex-shrink-0 shadow-inner">
					<i class="fa-solid fa-right-to-bracket"></i>
				</div>
				<div>
					<h1 class="text-2xl font-extrabold text-slate-900 tracking-tight">
						{translate key="user.login"}
					</h1>
					<p class="text-xs sm:text-sm text-slate-500 mt-0.5">
						{translate key="plugins.themes.rumahJurnal.auth.loginSubtitle"}
					</p>
				</div>
			</div>

			<!-- Error Message Box -->
			{if $error}
				<div class="mb-6 p-4 rounded-xl bg-rose-50 border border-rose-200 text-rose-800 text-xs sm:text-sm flex items-start gap-3" role="alert">
					<i class="fa-solid fa-circle-exclamation text-rose-500 text-lg mt-0.5 flex-shrink-0"></i>
					<div class="font-medium leading-relaxed">
						{translate key=$error reason=$reason}
					</div>
				</div>
			{/if}

			<!-- Redirect Login Message -->
			{if $loginMessage}
				<div class="mb-6 p-4 rounded-xl bg-amber-50 border border-amber-200 text-amber-800 text-xs sm:text-sm flex items-start gap-3" role="status">
					<i class="fa-solid fa-circle-info text-amber-500 text-lg mt-0.5 flex-shrink-0"></i>
					<div class="font-medium leading-relaxed">
						{translate key=$loginMessage}
					</div>
				</div>
			{/if}

			<!-- Login Form -->
			<form class="space-y-5" id="login" method="post" action="{$loginUrl}" role="form" x-data="{ showPassword: false }">
				{csrf}
				<input type="hidden" name="source" value="{$source|default:""|escape}" />

				<!-- Username / Email Field -->
				<div>
					<label for="username" class="block text-xs sm:text-sm font-bold text-slate-700 mb-1.5">
						{translate key="user.usernameOrEmail"}
						<span class="text-rose-500" title="{translate key="common.required"}">*</span>
					</label>
					<div class="relative">
						<div class="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none text-slate-400">
							<i class="fa-solid fa-user text-sm"></i>
						</div>
						<input type="text"
							name="username"
							id="username"
							value="{$username|default:""|escape}"
							required
							aria-required="true"
							autocomplete="username"
							placeholder="{translate key="plugins.themes.rumahJurnal.auth.usernamePlaceholder"}"
							class="w-full pl-10 pr-4 py-3 rounded-xl border border-slate-300 text-slate-800 text-sm placeholder-slate-400 bg-slate-50/50 focus:bg-white focus:outline-none focus:border-primary focus:ring-2 focus:ring-primary/20 transition duration-200">
					</div>
				</div>

				<!-- Password Field -->
				<div>
					<div class="flex items-center justify-between mb-1.5">
						<label for="password" class="block text-xs sm:text-sm font-bold text-slate-700">
							{translate key="user.password"}
							<span class="text-rose-500" title="{translate key="common.required"}">*</span>
						</label>
						<a href="{url page="login" op="lostPassword"}" class="text-xs font-semibold text-primary hover:text-accent transition">
							{translate key="user.login.forgotPassword"}
						</a>
					</div>
					<div class="relative">
						<div class="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none text-slate-400">
							<i class="fa-solid fa-lock text-sm"></i>
						</div>
						<input :type="showPassword ? 'text' : 'password'"
							name="password"
							id="password"
							value="{$password|default:""|escape}"
							password="true"
							maxlength="32"
							required
							aria-required="true"
							autocomplete="current-password"
							placeholder="{translate key="plugins.themes.rumahJurnal.auth.passwordPlaceholder"}"
							class="w-full pl-10 pr-11 py-3 rounded-xl border border-slate-300 text-slate-800 text-sm placeholder-slate-400 bg-slate-50/50 focus:bg-white focus:outline-none focus:border-primary focus:ring-2 focus:ring-primary/20 transition duration-200">
						<button type="button"
							@click="showPassword = !showPassword"
							tabindex="-1"
							class="absolute inset-y-0 right-0 pr-3.5 flex items-center text-slate-400 hover:text-slate-700 focus:outline-none transition"
							:title="showPassword ? '{translate key="plugins.themes.rumahJurnal.auth.hidePassword"}' : '{translate key="plugins.themes.rumahJurnal.auth.showPassword"}'">
							<i class="fa-solid" :class="showPassword ? 'fa-eye-slash' : 'fa-eye'"></i>
						</button>
					</div>
				</div>

				<!-- Remember Me Checkbox -->
				<div class="flex items-center justify-between pt-1">
					<label class="flex items-center gap-2.5 cursor-pointer select-none group">
						<input type="checkbox"
							name="remember"
							id="remember"
							value="1"
							{if $remember}checked="checked"{/if}
							class="w-4 h-4 rounded border-slate-300 text-primary focus:ring-primary/30 cursor-pointer">
						<span class="text-xs sm:text-sm text-slate-600 group-hover:text-slate-800 font-medium transition">
							{translate key="user.login.rememberUsernameAndPassword"}
						</span>
					</label>
				</div>

				<!-- reCAPTCHA Verification (if enabled in OJS) -->
				{if $recaptchaPublicKey}
					<div class="recaptcha_wrapper my-3">
						<div class="g-recaptcha" data-sitekey="{$recaptchaPublicKey|escape}"></div>
						<label for="g-recaptcha-response" class="sr-only">Recaptcha response</label>
					</div>
				{/if}

				<!-- ALTCHA Verification (if enabled in OJS 3.5) -->
				{if $altchaEnabled}
					<div class="altcha_wrapper my-3">
						<altcha-widget challengejson='{$altchaChallenge|@json_encode}' floating></altcha-widget>
					</div>
				{/if}

				<!-- Submit Button -->
				<div class="pt-2">
					<button type="submit"
						class="w-full py-3.5 px-6 rounded-xl font-bold text-sm bg-primary text-white shadow-md hover:shadow-lg hover:bg-primary-800 active:scale-[0.99] transition duration-200 flex items-center justify-center gap-2.5">
						<i class="fa-solid fa-arrow-right-to-bracket text-base"></i>
						<span>{translate key="user.login"}</span>
					</button>
				</div>

				<!-- Registration Link (if registration is enabled) -->
				{if !$disableUserReg}
					{capture assign=registerUrl}{url page="user" op="register" source=$source}{/capture}
					<div class="pt-6 mt-6 border-t border-slate-100 text-center">
						<p class="text-xs sm:text-sm text-slate-600 mb-3">
							{translate key="plugins.themes.rumahJurnal.auth.noAccountPrompt"}
						</p>
						<a href="{$registerUrl}"
							class="inline-flex items-center justify-center gap-2 w-full py-2.5 px-4 rounded-xl border border-slate-300 bg-white hover:bg-slate-50 text-slate-700 text-xs sm:text-sm font-bold shadow-sm hover:border-slate-400 transition duration-200">
							<i class="fa-solid fa-user-plus text-accent"></i>
							<span>{translate key="user.login.registerNewAccount"}</span>
						</a>
					</div>
				{/if}
			</form>
		</div>
	</div>
</div>

{include file="frontend/components/footer.tpl"}
