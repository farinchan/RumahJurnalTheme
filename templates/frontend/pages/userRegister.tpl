{**
 * plugins/themes/rumahJurnal/templates/frontend/pages/userRegister.tpl
 *
 * Copyright (c) 2026 Fajri Rinaldi Chan
 * Theme Support: https://nagastra.org
 *
 * Modern user registration page for Rumah Jurnal theme.
 *}
{include file="frontend/components/header.tpl" pageTitle="user.register"}

{assign var="siteContextId" value=PKP\core\PKPApplication::SITE_CONTEXT_ID|intval}

<div class="py-6 sm:py-10 max-w-2xl mx-auto">
	<!-- BREADCRUMBS -->
	<nav class="flex items-center gap-2 text-xs text-slate-500 mb-8" aria-label="Breadcrumb">
		<a href="{url page="index" router=PKP\core\PKPApplication::ROUTE_PAGE}" class="hover:text-primary transition flex items-center gap-1.5 font-medium">
			<i class="fa-solid fa-house text-slate-400"></i>
			<span>{translate key="common.homepageNavigationLabel"}</span>
		</a>
		<i class="fa-solid fa-chevron-right text-[10px] text-slate-400"></i>
		<span class="text-slate-800 font-semibold">{translate key="user.register"}</span>
	</nav>

	<!-- REGISTRATION CARD -->
	<div class="bg-white rounded-2xl shadow-xl shadow-slate-200/70 border border-slate-200/90 relative overflow-hidden">
		<!-- Top Accent Gradient Line -->
		<div class="h-1.5 w-full bg-gradient-to-r from-primary via-accent to-primary-light"></div>

		<div class="p-6 sm:p-10">
			<!-- Header -->
			<div class="flex items-center gap-3.5 mb-6">
				<div class="w-12 h-12 rounded-xl bg-primary-50 text-primary flex items-center justify-center text-xl font-bold flex-shrink-0 shadow-inner">
					<i class="fa-solid fa-user-plus"></i>
				</div>
				<div>
					<h1 class="text-2xl font-extrabold text-slate-900 tracking-tight">
						{translate key="user.register"}
					</h1>
					<p class="text-xs sm:text-sm text-slate-500 mt-0.5">
						{translate key="plugins.themes.rumahJurnal.auth.registerSubtitle"}
					</p>
				</div>
			</div>

			<!-- Error Message Box -->
			{if $isError}
				<div class="mb-6 p-4 rounded-xl bg-rose-50 border border-rose-200 text-rose-800 text-xs sm:text-sm" role="alert" id="formErrors">
					<div class="font-bold flex items-center gap-2 text-rose-700 mb-2">
						<i class="fa-solid fa-circle-exclamation text-rose-500 text-base"></i>
						<span>{translate key="form.errorsOccurred"}:</span>
					</div>
					<ul class="list-disc list-inside space-y-1 text-rose-700">
						{foreach key=field item=message from=$errors}
							<li>{$message}</li>
						{/foreach}
					</ul>
				</div>
			{/if}

			<!-- Registration Form -->
			<form class="space-y-6" id="register" method="post" action="{url op="register"}" role="form" x-data="{ showPassword: false, showPassword2: false, showRoles: false }">
				{if $orcidEnabled}
					<div class="p-4 rounded-xl bg-slate-50 border border-slate-200 mb-4">
						{include file="form/orcidProfile.tpl"}
					</div>
				{/if}

				{csrf}

				{if $source}
					<input type="hidden" name="source" value="{$source|escape}" />
				{/if}

				<!-- SECTION 1: PROFIL PENGGUNA -->
				<div class="space-y-4">
					<div class="flex items-center gap-2 pb-2 border-b border-slate-100">
						<span class="w-2 h-2 rounded-full bg-accent"></span>
						<h2 class="text-sm font-bold text-slate-800 uppercase tracking-wider">
							{translate key="user.profile"}
						</h2>
					</div>

					<div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
						<!-- Given Name -->
						<div>
							<label for="givenName" class="block text-xs sm:text-sm font-bold text-slate-700 mb-1.5">
								{translate key="user.givenName"}
								<span class="text-rose-500" title="{translate key="common.required"}">*</span>
							</label>
							<div class="relative">
								<div class="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none text-slate-400">
									<i class="fa-solid fa-user text-sm"></i>
								</div>
								<input type="text"
									name="givenName"
									id="givenName"
									value="{$givenName|default:""|escape}"
									maxlength="255"
									required
									aria-required="true"
									autocomplete="given-name"
									placeholder="{translate key="plugins.themes.rumahJurnal.auth.givenNamePlaceholder"}"
									class="w-full pl-10 pr-4 py-2.5 rounded-xl border border-slate-300 text-slate-800 text-sm placeholder-slate-400 bg-slate-50/50 focus:bg-white focus:outline-none focus:border-primary focus:ring-2 focus:ring-primary/20 transition duration-200">
							</div>
						</div>

						<!-- Family Name -->
						<div>
							<label for="familyName" class="block text-xs sm:text-sm font-bold text-slate-700 mb-1.5">
								{translate key="user.familyName"}
								<span class="text-slate-400 text-xs font-normal">({translate key="plugins.themes.rumahJurnal.common.optional"})</span>
							</label>
							<div class="relative">
								<div class="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none text-slate-400">
									<i class="fa-solid fa-user text-sm"></i>
								</div>
								<input type="text"
									name="familyName"
									id="familyName"
									value="{$familyName|default:""|escape}"
									maxlength="255"
									autocomplete="family-name"
									placeholder="{translate key="plugins.themes.rumahJurnal.auth.familyNamePlaceholder"}"
									class="w-full pl-10 pr-4 py-2.5 rounded-xl border border-slate-300 text-slate-800 text-sm placeholder-slate-400 bg-slate-50/50 focus:bg-white focus:outline-none focus:border-primary focus:ring-2 focus:ring-primary/20 transition duration-200">
							</div>
						</div>
					</div>

					<!-- Affiliation -->
					<div>
						<label for="affiliation" class="block text-xs sm:text-sm font-bold text-slate-700 mb-1.5">
							{translate key="user.affiliation"}
							<span class="text-rose-500" title="{translate key="common.required"}">*</span>
						</label>
						<div class="relative">
							<div class="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none text-slate-400">
								<i class="fa-solid fa-building-columns text-sm"></i>
							</div>
							<input type="text"
								name="affiliation"
								id="affiliation"
								value="{$affiliation|default:""|escape}"
								required
								aria-required="true"
								autocomplete="organization"
								placeholder="{translate key="plugins.themes.rumahJurnal.auth.affiliationPlaceholder"}"
								class="w-full pl-10 pr-4 py-2.5 rounded-xl border border-slate-300 text-slate-800 text-sm placeholder-slate-400 bg-slate-50/50 focus:bg-white focus:outline-none focus:border-primary focus:ring-2 focus:ring-primary/20 transition duration-200">
						</div>
					</div>

					<!-- Country -->
					<div>
						<label for="country" class="block text-xs sm:text-sm font-bold text-slate-700 mb-1.5">
							{translate key="common.country"}
							<span class="text-rose-500" title="{translate key="common.required"}">*</span>
						</label>
						<div class="relative">
							<div class="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none text-slate-400">
								<i class="fa-solid fa-globe text-sm"></i>
							</div>
							<select name="country"
								id="country"
								required
								aria-required="true"
								autocomplete="country-name"
								class="w-full pl-10 pr-8 py-2.5 rounded-xl border border-slate-300 text-slate-800 text-sm bg-slate-50/50 focus:bg-white focus:outline-none focus:border-primary focus:ring-2 focus:ring-primary/20 transition duration-200">
								<option value="">-- {translate key="common.country"} --</option>
								{html_options options=$countries selected=$country}
							</select>
						</div>
					</div>
				</div>

				<!-- SECTION 2: KREDENSIAL LOGIN -->
				<div class="space-y-4 pt-2">
					<div class="flex items-center gap-2 pb-2 border-b border-slate-100">
						<span class="w-2 h-2 rounded-full bg-accent"></span>
						<h2 class="text-sm font-bold text-slate-800 uppercase tracking-wider">
							{translate key="user.login"}
						</h2>
					</div>

					<div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
						<!-- Email -->
						<div>
							<label for="email" class="block text-xs sm:text-sm font-bold text-slate-700 mb-1.5">
								{translate key="user.email"}
								<span class="text-rose-500" title="{translate key="common.required"}">*</span>
							</label>
							<div class="relative">
								<div class="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none text-slate-400">
									<i class="fa-solid fa-envelope text-sm"></i>
								</div>
								<input type="email"
									name="email"
									id="email"
									value="{$email|default:""|escape}"
									maxlength="90"
									required
									aria-required="true"
									autocomplete="email"
									placeholder="{translate key="plugins.themes.rumahJurnal.auth.emailPlaceholder"}"
									class="w-full pl-10 pr-4 py-2.5 rounded-xl border border-slate-300 text-slate-800 text-sm placeholder-slate-400 bg-slate-50/50 focus:bg-white focus:outline-none focus:border-primary focus:ring-2 focus:ring-primary/20 transition duration-200">
							</div>
						</div>

						<!-- Phone -->
						<div>
							<label for="phone" class="block text-xs sm:text-sm font-bold text-slate-700 mb-1.5">
								{translate key="user.phone"}
								<span class="text-slate-400 text-xs font-normal">({translate key="plugins.themes.rumahJurnal.common.optional"})</span>
							</label>
							<div class="relative">
								<div class="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none text-slate-400">
									<i class="fa-solid fa-phone text-sm"></i>
								</div>
								<input type="text"
									name="phone"
									id="phone"
									value="{$phone|default:""|escape}"
									maxlength="255"
									autocomplete="phone"
									placeholder="{translate key="plugins.themes.rumahJurnal.auth.phonePlaceholder"}"
									class="w-full pl-10 pr-4 py-2.5 rounded-xl border border-slate-300 text-slate-800 text-sm placeholder-slate-400 bg-slate-50/50 focus:bg-white focus:outline-none focus:border-primary focus:ring-2 focus:ring-primary/20 transition duration-200">
							</div>
						</div>
					</div>

					<!-- Username -->
					<div>
						<label for="username" class="block text-xs sm:text-sm font-bold text-slate-700 mb-1.5">
							{translate key="user.username"}
							<span class="text-rose-500" title="{translate key="common.required"}">*</span>
						</label>
						<div class="relative">
							<div class="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none text-slate-400">
								<i class="fa-solid fa-at text-sm"></i>
							</div>
							<input type="text"
								name="username"
								id="username"
								value="{$username|default:""|escape}"
								maxlength="32"
								required
								aria-required="true"
								autocomplete="username"
								placeholder="{translate key="plugins.themes.rumahJurnal.auth.usernameNewPlaceholder"}"
								class="w-full pl-10 pr-4 py-2.5 rounded-xl border border-slate-300 text-slate-800 text-sm placeholder-slate-400 bg-slate-50/50 focus:bg-white focus:outline-none focus:border-primary focus:ring-2 focus:ring-primary/20 transition duration-200">
						</div>
						<p class="text-[11px] text-slate-500 mt-1">
							{translate key="plugins.themes.rumahJurnal.auth.usernameRules"}
						</p>
					</div>

					<div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
						<!-- Password -->
						<div>
							<label for="password" class="block text-xs sm:text-sm font-bold text-slate-700 mb-1.5">
								{translate key="user.password"}
								<span class="text-rose-500" title="{translate key="common.required"}">*</span>
							</label>
							<div class="relative">
								<div class="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none text-slate-400">
									<i class="fa-solid fa-lock text-sm"></i>
								</div>
								<input :type="showPassword ? 'text' : 'password'"
									name="password"
									id="password"
									password="true"
									maxlength="32"
									required
									aria-required="true"
									autocomplete="new-password"
									placeholder="{translate key="plugins.themes.rumahJurnal.auth.passwordNewPlaceholder"}"
									class="w-full pl-10 pr-10 py-2.5 rounded-xl border border-slate-300 text-slate-800 text-sm placeholder-slate-400 bg-slate-50/50 focus:bg-white focus:outline-none focus:border-primary focus:ring-2 focus:ring-primary/20 transition duration-200">
								<button type="button"
									@click="showPassword = !showPassword"
									tabindex="-1"
									class="absolute inset-y-0 right-0 pr-3 flex items-center text-slate-400 hover:text-slate-700 focus:outline-none transition">
									<i class="fa-solid" :class="showPassword ? 'fa-eye-slash' : 'fa-eye'"></i>
								</button>
							</div>
						</div>

						<!-- Repeat Password -->
						<div>
							<label for="password2" class="block text-xs sm:text-sm font-bold text-slate-700 mb-1.5">
								{translate key="user.repeatPassword"}
								<span class="text-rose-500" title="{translate key="common.required"}">*</span>
							</label>
							<div class="relative">
								<div class="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none text-slate-400">
									<i class="fa-solid fa-lock text-sm"></i>
								</div>
								<input :type="showPassword2 ? 'text' : 'password'"
									name="password2"
									id="password2"
									password="true"
									maxlength="32"
									required
									aria-required="true"
									autocomplete="new-password"
									placeholder="{translate key="plugins.themes.rumahJurnal.auth.repeatPasswordPlaceholder"}"
									class="w-full pl-10 pr-10 py-2.5 rounded-xl border border-slate-300 text-slate-800 text-sm placeholder-slate-400 bg-slate-50/50 focus:bg-white focus:outline-none focus:border-primary focus:ring-2 focus:ring-primary/20 transition duration-200">
								<button type="button"
									@click="showPassword2 = !showPassword2"
									tabindex="-1"
									class="absolute inset-y-0 right-0 pr-3 flex items-center text-slate-400 hover:text-slate-700 focus:outline-none transition">
									<i class="fa-solid" :class="showPassword2 ? 'fa-eye-slash' : 'fa-eye'"></i>
								</button>
							</div>
						</div>
					</div>
				</div>

				<!-- SECTION 3: BIDANG KEAHLIAN (REVIEWER) -->
				{if !$currentContext}
					<div class="space-y-2 pt-2">
						<label for="interests" class="block text-xs sm:text-sm font-bold text-slate-700">
							{translate key="user.register.noContextReviewerInterests"}
						</label>
						<div class="relative">
							<div class="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none text-slate-400">
								<i class="fa-solid fa-tags text-sm"></i>
							</div>
							<input type="text"
								name="interests"
								id="interests"
								value="{$interests|default:""|escape}"
								placeholder="{translate key="plugins.themes.rumahJurnal.auth.reviewerInterestsPlaceholder"}"
								class="w-full pl-10 pr-4 py-2.5 rounded-xl border border-slate-300 text-slate-800 text-sm placeholder-slate-400 bg-slate-50/50 focus:bg-white focus:outline-none focus:border-primary focus:ring-2 focus:ring-primary/20 transition duration-200">
						</div>
					</div>
				{else}
					{* Context-specific reviewer role opt-in *}
					{assign var=contextId value=$currentContext->getId()}
					{assign var=userCanRegisterReviewer value=0}
					{foreach from=$reviewerUserGroups[$contextId] item=userGroup}
						{if $userGroup->permitSelfRegistration}
							{assign var=userCanRegisterReviewer value=$userCanRegisterReviewer+1}
						{/if}
					{/foreach}
					{if $userCanRegisterReviewer}
						<div class="p-4 rounded-xl bg-slate-50 border border-slate-200 space-y-3">
							<h3 class="text-xs sm:text-sm font-bold text-slate-800">
								{translate key="user.reviewerPrompt"}
							</h3>
							<div class="space-y-2">
								{foreach from=$reviewerUserGroups[$contextId] item=userGroup}
									{if $userGroup->permitSelfRegistration}
										{assign var="userGroupId" value=$userGroup->id}
										<label class="flex items-center gap-2 cursor-pointer text-xs sm:text-sm text-slate-700">
											<input type="checkbox" name="reviewerGroup[{$userGroupId}]" value="1"{if in_array($userGroupId, $userGroupIds)} checked="checked"{/if}
												class="w-4 h-4 rounded border-slate-300 text-primary focus:ring-primary/30">
											<span>{translate key="user.reviewerPrompt.optin" userGroup=$userGroup->getLocalizedData('name')}</span>
										</label>
									{/if}
								{/foreach}
							</div>
							<div>
								<label for="interests" class="block text-xs font-semibold text-slate-600 mb-1">
									{translate key="user.interests"}
								</label>
								<input type="text" name="interests" id="interests" value="{$interests|default:""|escape}"
									class="w-full px-3 py-2 rounded-lg border border-slate-300 text-xs sm:text-sm bg-white focus:outline-none focus:border-primary">
							</div>
						</div>
					{/if}
				{/if}

				<!-- SECTION 4: PILIHAN JURNAL (Jika pendaftaran di tingkat portal) -->
				{if !$currentContext && $contexts}
					<div class="pt-2 border-t border-slate-100">
						<button type="button" @click="showRoles = !showRoles"
							class="flex items-center justify-between w-full p-3.5 rounded-xl bg-slate-50 hover:bg-slate-100 border border-slate-200 transition text-left">
							<div class="flex items-center gap-2.5">
								<i class="fa-solid fa-book-bookmark text-primary"></i>
								<div>
									<span class="text-xs sm:text-sm font-bold text-slate-800 block">
										{translate key="user.register.contextsPrompt"}
									</span>
									<span class="text-[11px] text-slate-500">
										{translate key="plugins.themes.rumahJurnal.auth.contextsPromptSubtitle"}
									</span>
								</div>
							</div>
							<i class="fa-solid fa-chevron-down text-xs text-slate-400 transition-transform duration-200" :class="{ 'rotate-180': showRoles }"></i>
						</button>

						<div x-show="showRoles" x-collapse class="mt-3 p-4 rounded-xl border border-slate-200 bg-slate-50/50 max-h-64 overflow-y-auto space-y-4">
							{foreach from=$contexts item=context}
								{assign var=contextId value=$context->getId()}
								<div class="pb-3 border-b border-slate-200/80 last:border-b-0 last:pb-0">
									<h4 class="text-xs font-bold text-slate-800 mb-1.5 flex items-center gap-1.5">
										<i class="fa-solid fa-book text-[10px] text-accent"></i>
										<span>{$context->getLocalizedName()}</span>
									</h4>
									<div class="flex flex-wrap gap-4 text-xs text-slate-600 pl-4">
										{foreach from=$readerUserGroups[$contextId] item=userGroup}
											{if $userGroup->permitSelfRegistration}
												{assign var="userGroupId" value=$userGroup->id}
												<label class="inline-flex items-center gap-1.5 cursor-pointer">
													<input type="checkbox" name="readerGroup[{$userGroupId}]"{if in_array($userGroupId, $userGroupIds)} checked="checked"{/if}
														class="w-3.5 h-3.5 rounded border-slate-300 text-primary">
													<span>{$userGroup->getLocalizedData('name')}</span>
												</label>
											{/if}
										{/foreach}
										{foreach from=$reviewerUserGroups[$contextId] item=userGroup}
											{if $userGroup->permitSelfRegistration}
												{assign var="userGroupId" value=$userGroup->id}
												<label class="inline-flex items-center gap-1.5 cursor-pointer">
													<input type="checkbox" name="reviewerGroup[{$userGroupId}]"{if in_array($userGroupId, $userGroupIds)} checked="checked"{/if}
														class="w-3.5 h-3.5 rounded border-slate-300 text-primary">
													<span>{$userGroup->getLocalizedData('name')}</span>
												</label>
											{/if}
										{/foreach}
									</div>
								</div>
							{/foreach}
						</div>
					</div>
				{/if}

				<!-- SECTION 5: CONSENTS & PERSETUJUAN -->
				<div class="space-y-3 pt-3 border-t border-slate-100">
					<!-- Privacy Statement Consent -->
					{if $currentContext && $currentContext->getData('privacyStatement')}
						<label class="flex items-start gap-2.5 cursor-pointer select-none">
							<input type="checkbox" name="privacyConsent" value="1"{if $privacyConsent} checked="checked"{/if}
								class="w-4 h-4 mt-0.5 rounded border-slate-300 text-primary focus:ring-primary/30 cursor-pointer">
							<span class="text-xs text-slate-600 font-medium leading-relaxed">
								{capture assign="privacyUrl"}{url router=PKP\core\PKPApplication::ROUTE_PAGE page="about" op="privacy"}{/capture}
								{translate key="user.register.form.privacyConsent" privacyUrl=$privacyUrl}
							</span>
						</label>
					{/if}

					{if !$currentContext && $siteWidePrivacyStatement}
						<label class="flex items-start gap-2.5 cursor-pointer select-none">
							<input type="checkbox" name="privacyConsent[{$siteContextId}]" id="privacyConsent[{$siteContextId}]" value="1"{if $privacyConsent[$siteContextId]} checked="checked"{/if}
								class="w-4 h-4 mt-0.5 rounded border-slate-300 text-primary focus:ring-primary/30 cursor-pointer">
							<span class="text-xs text-slate-600 font-medium leading-relaxed">
								{capture assign="privacyUrl"}{url router=PKP\core\PKPApplication::ROUTE_PAGE page="about" op="privacy"}{/capture}
								{translate key="user.register.form.privacyConsent" privacyUrl=$privacyUrl}
							</span>
						</label>
					{/if}

					<!-- Email Notification Consent -->
					<label class="flex items-start gap-2.5 cursor-pointer select-none">
						<input type="checkbox" name="emailConsent" value="1"{if $emailConsent} checked="checked"{/if}
							class="w-4 h-4 mt-0.5 rounded border-slate-300 text-primary focus:ring-primary/30 cursor-pointer">
						<span class="text-xs text-slate-600 font-medium leading-relaxed">
							{translate key="user.register.form.emailConsent"}
						</span>
					</label>
				</div>

				<!-- Spam Blockers -->
				{if $recaptchaPublicKey}
					<div class="recaptcha_wrapper my-3">
						<div class="g-recaptcha" data-sitekey="{$recaptchaPublicKey|escape}"></div>
						<label for="g-recaptcha-response" class="sr-only">Recaptcha response</label>
					</div>
				{/if}

				{if $altchaEnabled}
					<div class="altcha_wrapper my-3">
						<altcha-widget challengejson='{$altchaChallenge|@json_encode}' floating></altcha-widget>
					</div>
				{/if}

				<!-- Submit Button -->
				<div class="pt-2">
					<button type="submit"
						class="w-full py-3.5 px-6 rounded-xl font-bold text-sm bg-primary text-white shadow-md hover:shadow-lg hover:bg-primary-800 active:scale-[0.99] transition duration-200 flex items-center justify-center gap-2.5">
						<i class="fa-solid fa-user-plus text-base"></i>
						<span>{translate key="user.register"}</span>
					</button>
				</div>

				<!-- Login Link -->
				<div class="pt-5 border-t border-slate-100 text-center">
					<p class="text-xs sm:text-sm text-slate-600 mb-2">
						{translate key="plugins.themes.rumahJurnal.auth.alreadyHaveAccount"}
					</p>
					{capture assign="rolesProfileUrl"}{url page="user" op="profile" path="roles"}{/capture}
					<a href="{url page="login" source=$rolesProfileUrl}"
						class="inline-flex items-center justify-center gap-2 w-full py-2.5 px-4 rounded-xl border border-slate-300 bg-white hover:bg-slate-50 text-slate-700 text-xs sm:text-sm font-bold shadow-sm hover:border-slate-400 transition duration-200">
						<i class="fa-solid fa-arrow-right-to-bracket text-accent"></i>
						<span>{translate key="user.login"}</span>
					</a>
				</div>
			</form>
		</div>
	</div>
</div>

{include file="frontend/components/footer.tpl"}
