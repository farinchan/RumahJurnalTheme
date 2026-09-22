<?php

/**
 * @file plugins/themes/rumahJurnal/RumahJurnalThemePlugin.php
 *
 * Copyright (c) 2026 Rumah Jurnal
 *
 * @class RumahJurnalThemePlugin
 *
 * @brief Rumah Jurnal Theme - Modern Portal Theme for OJS 3.5
 */

namespace APP\plugins\themes\rumahJurnal;

use APP\core\Application;
use APP\file\PublicFileManager;
use PKP\facades\Locale;
use PKP\plugins\Hook;
use PKP\plugins\ThemePlugin;
use PKP\template\PKPTemplateManager;
use Illuminate\Support\Facades\DB;

class RumahJurnalThemePlugin extends ThemePlugin
{

    /**
     * Initialize theme styles, scripts and template overrides
     */
    public function init()
    {
        // Register theme customizable color options for Admin Settings
        $this->addOption('primaryColor', 'FieldColor', [
            'label' => __('plugins.themes.rumahJurnal.option.primaryColor.label'),
            'description' => __('plugins.themes.rumahJurnal.option.primaryColor.description'),
            'default' => '#2C366D',
        ]);

        $this->addOption('secondaryColor', 'FieldColor', [
            'label' => __('plugins.themes.rumahJurnal.option.secondaryColor.label'),
            'description' => __('plugins.themes.rumahJurnal.option.secondaryColor.description'),
            'default' => '#D2AA2A',
        ]);

        $this->addOption('heroTitle', 'FieldText', [
            'label' => __('plugins.themes.rumahJurnal.option.heroTitle.label'),
            'description' => __('plugins.themes.rumahJurnal.option.heroTitle.description'),
            'default' => 'Portal Publikasi Ilmiah & Riset Terbuka',
        ]);

        $this->addOption('heroDescription', 'FieldTextarea', [
            'label' => __('plugins.themes.rumahJurnal.option.heroDescription.label'),
            'description' => __('plugins.themes.rumahJurnal.option.heroDescription.description'),
            'default' => 'Menyajikan akses terbuka (Open Access) ke puluhan berkala ilmiah terindeks nasional (SINTA) dan internasional di lingkungan Universitas Islam Negeri Mahmud Yunus Batusangkar.',
        ]);

        // Add Google Fonts: Plus Jakarta Sans & Outfit
        $this->addStyle(
            'googleFonts',
            'https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&family=Outfit:wght@400;500;600;700;800&display=swap',
            ['baseUrl' => '']
        );

        // Add FontAwesome 6 Free CDN for rich icons
        $this->addStyle(
            'fontAwesome6',
            'https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css',
            ['baseUrl' => '']
        );

        // Add custom portal CSS
        $this->addStyle('rumahJurnalPortal', 'styles/rumah-jurnal.css');

        // Inject dynamic theme color CSS variables
        $this->addStyle(
            'rumahJurnalDynamicColors',
            $this->getDynamicColorsCss(),
            ['inline' => true, 'priority' => PKPTemplateManager::STYLE_SEQUENCE_CORE]
        );

        // Add Tailwind CSS CDN script
        $this->addScript(
            'tailwindCDN',
            'https://cdn.tailwindcss.com',
            ['baseUrl' => '', 'priority' => PKPTemplateManager::STYLE_SEQUENCE_CORE]
        );

        // Add Tailwind Config inline script
        $this->addScript(
            'tailwindConfig',
            $this->getTailwindConfigJs(),
            ['inline' => true, 'priority' => PKPTemplateManager::STYLE_SEQUENCE_CORE]
        );

        // Add Alpine.js for instantaneous client-side searching, filtering, and tab switching
        $this->addScript(
            'alpineJs',
            'https://cdn.jsdelivr.net/npm/alpinejs@3.14.3/dist/cdn.min.js',
            ['baseUrl' => '', 'priority' => PKPTemplateManager::STYLE_SEQUENCE_LATE]
        );

        // Add theme main JS
        $this->addScript('rumahJurnalJs', 'js/rumah-jurnal.js');

        // Hook into TemplateManager::display to supply enriched data for indexSite.tpl
        Hook::add('TemplateManager::display', [$this, 'enrichSiteIndexData']);
    }

    /**
     * Get primary color with fallback
     */
    public function getPrimaryColor(): string
    {
        $color = (string) $this->getOption('primaryColor');
        if (empty($color)) {
            /** @var \PKP\plugins\PluginSettingsDAO $pluginSettingsDao */
            $pluginSettingsDao = \PKP\db\DAORegistry::getDAO('PluginSettingsDAO');
            $siteSettings = $pluginSettingsDao->getPluginSettings(null, $this->getName());
            $color = $siteSettings['primaryColor'] ?? '';
        }
        if (empty($color)) {
            $color = '#2C366D';
        }
        return '#' . ltrim($color, '#');
    }

    /**
     * Get secondary / accent color with fallback
     */
    public function getSecondaryColor(): string
    {
        $color = (string) $this->getOption('secondaryColor');
        if (empty($color)) {
            /** @var \PKP\plugins\PluginSettingsDAO $pluginSettingsDao */
            $pluginSettingsDao = \PKP\db\DAORegistry::getDAO('PluginSettingsDAO');
            $siteSettings = $pluginSettingsDao->getPluginSettings(null, $this->getName());
            $color = $siteSettings['secondaryColor'] ?? '';
        }
        if (empty($color)) {
            $color = '#D2AA2A';
        }
        return '#' . ltrim($color, '#');
    }

    /**
     * Get hero headline title with fallback
     */
    public function getHeroTitle(): string
    {
        $title = (string) $this->getOption('heroTitle');
        if (empty($title)) {
            /** @var \PKP\plugins\PluginSettingsDAO $pluginSettingsDao */
            $pluginSettingsDao = \PKP\db\DAORegistry::getDAO('PluginSettingsDAO');
            $siteSettings = $pluginSettingsDao->getPluginSettings(null, $this->getName());
            $title = $siteSettings['heroTitle'] ?? '';
        }
        if (empty($title)) {
            $title = 'Portal Publikasi Ilmiah & Riset Terbuka';
        }
        return $title;
    }

    /**
     * Get hero description with fallback
     */
    public function getHeroDescription(): string
    {
        $desc = (string) $this->getOption('heroDescription');
        if (empty($desc)) {
            /** @var \PKP\plugins\PluginSettingsDAO $pluginSettingsDao */
            $pluginSettingsDao = \PKP\db\DAORegistry::getDAO('PluginSettingsDAO');
            $siteSettings = $pluginSettingsDao->getPluginSettings(null, $this->getName());
            $desc = $siteSettings['heroDescription'] ?? '';
        }
        if (empty($desc)) {
            $desc = 'Menyajikan akses terbuka (<span class="text-accent font-semibold">Open Access</span>) ke puluhan berkala ilmiah terindeks nasional (SINTA) dan internasional di lingkungan Universitas Islam Negeri Mahmud Yunus Batusangkar.';
        }
        return $desc;
    }

    /**
     * Adjust brightness of a hex color
     */
    public function adjustBrightness(string $hex, int $percent): string
    {
        $hex = ltrim($hex, '#');
        if (strlen($hex) === 3) {
            $hex = $hex[0] . $hex[0] . $hex[1] . $hex[1] . $hex[2] . $hex[2];
        }
        $r = hexdec(substr($hex, 0, 2));
        $g = hexdec(substr($hex, 2, 2));
        $b = hexdec(substr($hex, 4, 2));

        if ($percent > 0) {
            $r = (int) round($r + (255 - $r) * ($percent / 100));
            $g = (int) round($g + (255 - $g) * ($percent / 100));
            $b = (int) round($b + (255 - $b) * ($percent / 100));
        } else {
            $factor = (100 + $percent) / 100;
            $r = (int) round($r * $factor);
            $g = (int) round($g * $factor);
            $b = (int) round($b * $factor);
        }

        $r = max(0, min(255, $r));
        $g = max(0, min(255, $g));
        $b = max(0, min(255, $b));

        return sprintf('#%02x%02x%02x', $r, $g, $b);
    }

    /**
     * Generate 50..900 color scale
     */
    public function getColorScale(string $baseHex): array
    {
        return [
            '50' => $this->adjustBrightness($baseHex, 92),
            '100' => $this->adjustBrightness($baseHex, 80),
            '200' => $this->adjustBrightness($baseHex, 65),
            '300' => $this->adjustBrightness($baseHex, 45),
            '400' => $this->adjustBrightness($baseHex, 20),
            '500' => $baseHex,
            '600' => $this->adjustBrightness($baseHex, -15),
            '700' => $this->adjustBrightness($baseHex, -30),
            '800' => $this->adjustBrightness($baseHex, -50),
            '900' => $this->adjustBrightness($baseHex, -70),
        ];
    }

    /**
     * Generate dynamic CSS custom properties
     */
    public function getDynamicColorsCss(): string
    {
        $p = $this->getPrimaryColor();
        $s = $this->getSecondaryColor();
        $pScale = $this->getColorScale($p);
        $sScale = $this->getColorScale($s);

        return ":root {
  --rj-primary: {$p};
  --rj-primary-dark: {$pScale['800']};
  --rj-primary-light: {$pScale['400']};
  --rj-primary-50: {$pScale['50']};
  --rj-primary-100: {$pScale['100']};
  --rj-gold: {$s};
  --rj-gold-hover: {$sScale['600']};
  --rj-gold-light: {$sScale['100']};
  --rj-gold-50: {$sScale['50']};
  --rj-gold-border: {$sScale['300']};
}";
    }

    /**
     * Inline Tailwind configuration script.
     */
    public function getTailwindConfigJs(): string
    {
        $p = $this->getPrimaryColor();
        $s = $this->getSecondaryColor();
        $pScale = $this->getColorScale($p);
        $sScale = $this->getColorScale($s);

        $primaryJson = json_encode(array_merge(['DEFAULT' => $p], $pScale));
        $accentJson = json_encode(array_merge(['DEFAULT' => $s], $sScale));

        return '
        if (typeof tailwind !== "undefined") {
            tailwind.config = {
                theme: {
                    extend: {
                        colors: {
                            primary: ' . $primaryJson . ',
                            accent: ' . $accentJson . '
                        },
                        fontFamily: {
                            sans: ["Plus Jakarta Sans", "Inter", "system-ui", "sans-serif"],
                            display: ["Outfit", "Plus Jakarta Sans", "sans-serif"]
                        }
                    }
                }
            };
        }
        ';
    }

    /**
     * Enrich data passed to indexSite.tpl
     */
    public function enrichSiteIndexData(string $hookName, array $args): bool
    {
        $templateMgr = $args[0];
        $template = &$args[1];

        if ($template !== 'frontend/pages/indexSite.tpl') {
            return false;
        }

        try {
            $request = Application::get()->getRequest();
            $journals = $templateMgr->getTemplateVars('journals');

            if (!is_array($journals)) {
                return false;
            }

            // Fetch counts for articles & issues efficiently in bulk
            $articleCounts = DB::table('submissions')
                ->select('context_id', DB::raw('count(*) as count'))
                ->where('status', 3)
                ->groupBy('context_id')
                ->pluck('count', 'context_id');

            $issueCounts = DB::table('issues')
                ->select('journal_id', DB::raw('count(*) as count'))
                ->where('published', 1)
                ->groupBy('journal_id')
                ->pluck('count', 'journal_id');

            $journalFilesPath = $templateMgr->getTemplateVars('journalFilesPath');
            $enrichedJournals = [];
            $totalArticlesCount = 0;
            $totalIssuesCount = 0;
            $sintaCounts = 0;

            foreach ($journals as $journal) {
                $jId = $journal->getId();
                $path = $journal->getPath();
                $name = $journal->getLocalizedName();
                $rawDesc = (string) $journal->getLocalizedDescription();
                
                // Clean up narrative text by removing tables and formatting tags
                $narrativeDesc = preg_replace('/<table[\s\S]*?<\/table>/i', '', $rawDesc);
                $cleanDesc = trim(strip_tags($narrativeDesc));
                if (empty($cleanDesc)) {
                    $cleanDesc = trim(strip_tags($rawDesc));
                }
                $cleanDesc = preg_replace('/\s+/', ' ', $cleanDesc);
                if (mb_strlen($cleanDesc) > 175) {
                    $cleanDesc = mb_substr($cleanDesc, 0, 175) . '...';
                }

                $thumb = $journal->getLocalizedData('journalThumbnail');
                $thumbUrl = $thumb && !empty($thumb['uploadName'])
                    ? $journalFilesPath . $jId . '/' . rawurlencode($thumb['uploadName'])
                    : null;

                $pIssn = (string) ($journal->getData('printIssn') ?? '');
                $eIssn = (string) ($journal->getData('onlineIssn') ?? '');

                if (trim($pIssn) === '-') $pIssn = '';
                if (trim($eIssn) === '-') $eIssn = '';

                // Detect Sinta from description or metadata
                $sintaLevel = null;
                if (preg_match('/sinta\s*([1-6])/i', $rawDesc, $matches)) {
                    $sintaLevel = 'SINTA ' . $matches[1];
                    $sintaCounts++;
                } elseif (preg_match('/accredited\s*sinta|sinta\.png|sinta\.kemdikbud|sinta\.kemdiktisaintek|terakreditasi\s*sinta/i', $rawDesc)) {
                    $sintaLevel = 'SINTA';
                    $sintaCounts++;
                }

                // Detect Focus/Discipline Category
                $category = $this->detectCategory($name, $rawDesc, $path);

                $artCount = (int) ($articleCounts[$jId] ?? 0);
                $issCount = (int) ($issueCounts[$jId] ?? 0);
                $totalArticlesCount += $artCount;
                $totalIssuesCount += $issCount;

                $homeUrl = $request->getDispatcher()->url($request, \PKP\core\PKPApplication::ROUTE_PAGE, $path);
                $currentIssueUrl = $request->getDispatcher()->url($request, \PKP\core\PKPApplication::ROUTE_PAGE, $path, 'issue', 'current');
                $submitUrl = $request->getDispatcher()->url($request, \PKP\core\PKPApplication::ROUTE_PAGE, $path, 'about', 'submissions');

                $cleanLetters = preg_replace('/[^a-zA-Z]/', '', $name);
                $initial = strtoupper(substr($cleanLetters ?: $path, 0, 2));

                $enrichedJournals[] = [
                    'id' => $jId,
                    'path' => $path,
                    'name' => $name,
                    'cleanDescription' => $cleanDesc,
                    'thumbnailUrl' => $thumbUrl,
                    'printIssn' => $pIssn,
                    'onlineIssn' => $eIssn,
                    'sintaLevel' => $sintaLevel,
                    'category' => $category,
                    'articleCount' => $artCount,
                    'issueCount' => $issCount,
                    'homeUrl' => $homeUrl,
                    'currentIssueUrl' => $currentIssueUrl,
                    'submitUrl' => $submitUrl,
                    'initial' => $initial,
                ];
            }

            // Resolve Brand Logo from Admin Site Settings (Site Settings -> Appearance -> Logo)
            $site = $request->getSite();
            $siteLogo = null;
            if ($site) {
                $allLogos = $site->getData('pageHeaderTitleImage');
                if (is_array($allLogos)) {
                    $currentLocale = Locale::getLocale();
                    if (!empty($allLogos[$currentLocale]['uploadName'])) {
                        $siteLogo = $allLogos[$currentLocale];
                    } elseif (!empty($allLogos[$site->getPrimaryLocale()]['uploadName'])) {
                        $siteLogo = $allLogos[$site->getPrimaryLocale()];
                    } else {
                        foreach ($allLogos as $loc => $locLogo) {
                            if (is_array($locLogo) && !empty($locLogo['uploadName'])) {
                                $siteLogo = $locLogo;
                                break;
                            }
                        }
                    }
                }
            }

            // Direct DB fallback if not resolved via DataObject
            if (empty($siteLogo) || empty($siteLogo['uploadName'])) {
                $logoRows = DB::table('site_settings')
                    ->where('setting_name', 'pageHeaderTitleImage')
                    ->whereNotNull('setting_value')
                    ->get();
                foreach ($logoRows as $row) {
                    $decoded = json_decode($row->setting_value, true);
                    if (is_array($decoded) && !empty($decoded['uploadName'])) {
                        $siteLogo = $decoded;
                        break;
                    }
                }
            }

            $siteLogoUrl = null;
            $siteLogoAlt = null;
            $isWideLogo = false;
            if (!empty($siteLogo) && !empty($siteLogo['uploadName'])) {
                $publicFileManager = new PublicFileManager();
                $siteLogoUrl = $request->getBaseUrl() . '/' . $publicFileManager->getSiteFilesPath() . '/' . rawurlencode($siteLogo['uploadName']);
                $siteLogoAlt = !empty($siteLogo['altText']) ? $siteLogo['altText'] : ($site ? $site->getLocalizedTitle() : 'Rumah Jurnal');
                $width = (int) ($siteLogo['width'] ?? 0);
                $height = (int) ($siteLogo['height'] ?? 0);
                if ($height > 0 && ($width / $height) > 2.0) {
                    $isWideLogo = true;
                }
            }

            $primary = $this->getPrimaryColor();
            $secondary = $this->getSecondaryColor();
            $heroTitle = $this->getHeroTitle();
            $heroDescription = $this->getHeroDescription();

            // Resolve Page Footer from OJS Site Settings
            $pageFooter = $templateMgr->getTemplateVars('pageFooter');
            if (empty($pageFooter) && $site) {
                $pageFooter = $site->getLocalizedData('pageFooter');
                if (empty($pageFooter)) {
                    $allFooters = $site->getData('pageFooter');
                    if (is_array($allFooters)) {
                        $primaryLocale = $site->getPrimaryLocale();
                        $pageFooter = $allFooters[$primaryLocale] ?? reset($allFooters);
                    } elseif (is_string($allFooters)) {
                        $pageFooter = $allFooters;
                    }
                }
            }
            if (empty($pageFooter)) {
                $footerRow = DB::table('site_settings')
                    ->where('setting_name', 'pageFooter')
                    ->whereNotNull('setting_value')
                    ->first();
                if ($footerRow && !empty($footerRow->setting_value)) {
                    $pageFooter = $footerRow->setting_value;
                }
            }

            $templateMgr->assign([
                'pageFooter' => $pageFooter,
                'heroTitle' => $heroTitle,
                'heroDescription' => $heroDescription,
                'siteLogoUrl' => $siteLogoUrl,
                'siteLogoAlt' => $siteLogoAlt,
                'siteLogoIsWide' => $isWideLogo,
                'siteTitle' => $site ? $site->getLocalizedTitle() : 'Rumah Jurnal',
                'themePrimaryColor' => $primary,
                'themeSecondaryColor' => $secondary,
                'themePrimaryScale' => $this->getColorScale($primary),
                'themeSecondaryScale' => $this->getColorScale($secondary),
                'enrichedJournals' => $enrichedJournals,
                'journalsJson' => json_encode($enrichedJournals, JSON_HEX_TAG | JSON_HEX_APOS | JSON_HEX_AMP | JSON_HEX_QUOT),
                'portalTotalJournals' => count($enrichedJournals),
                'portalTotalArticles' => $totalArticlesCount,
                'portalTotalIssues' => $totalIssuesCount,
                'portalTotalSinta' => $sintaCounts,
            ]);
        } catch (\Throwable $e) {
            error_log('RumahJurnalThemePlugin::enrichSiteIndexData error: ' . $e->getMessage() . ' at line ' . $e->getLine());
        }

        return false;
    }

    /**
     * Categorize journal based on title, description, or path keywords
     */
    private function detectCategory(string $name, string $desc, string $path): string
    {
        $titlePath = strtolower($name . ' ' . $path);
        $text = strtolower($name . ' ' . $desc . ' ' . $path);

        // 1. Direct path/title matching
        if (preg_match('/sainstek|math|bansi|komputer|informatika|jamik/i', $titlePath)) {
            return 'Sains & Teknologi';
        }
        if (preg_match('/syariah|syari\'ah|hukum|law|ushuliy|juris|jisrah/i', $titlePath)) {
            return 'Syariah & Hukum';
        }
        if (preg_match('/ekonomi|bisnis|banking|perbankan|zakat|waqf|tourism|tamwil|mabis|zawa|jaksya|albank|al-bank|intifaq|imara/i', $titlePath)) {
            return 'Ekonomi & Bisnis Islam';
        }
        if (preg_match('/tarbiyah|pendidikan|education|keguruan|ta\'dib|edusainstika|ijecer|manapi|pilar/i', $titlePath)) {
            return 'Pendidikan & Tarbiyah';
        }
        if (preg_match('/bahasa|linguistik|arabic|english|lughawiyah|alsinah|linguavision/i', $titlePath)) {
            return 'Bahasa & Sastra';
        }
        if (preg_match('/komunikasi|penyiaran|media|psikologi|konseling|dakwah|sosial|indev|kinema|batanang|semantik|kaaffah|icon|alfuad|istinarah/i', $titlePath)) {
            return 'Sosial & Humaniora';
        }
        if (preg_match('/proceeding|konferensi/i', $titlePath)) {
            return 'Prosiding & Konferensi';
        }

        // 2. Fallback to full description
        if (preg_match('/sains|teknologi|natural science|mathematics|chemistry|biology/i', $text)) {
            return 'Sains & Teknologi';
        }
        if (preg_match('/syariah|syari\'ah|hukum|law/i', $text)) {
            return 'Syariah & Hukum';
        }
        if (preg_match('/ekonomi|bisnis|economic/i', $text)) {
            return 'Ekonomi & Bisnis Islam';
        }
        if (preg_match('/pendidikan|education|tarbiyah/i', $text)) {
            return 'Pendidikan & Tarbiyah';
        }
        if (preg_match('/language|linguistics|bahasa/i', $text)) {
            return 'Bahasa & Sastra';
        }
        if (preg_match('/sosial|humaniora|psychology|dakwah/i', $text)) {
            return 'Sosial & Humaniora';
        }

        return 'Keislaman & Multidisiplin';
    }

    /**
     * Get display name
     */
    public function getDisplayName()
    {
        return __('plugins.themes.rumahJurnal.name');
    }

    /**
     * Get description
     */
    public function getDescription()
    {
        return __('plugins.themes.rumahJurnal.description');
    }
}

if (!PKP_STRICT_MODE) {
    class_alias('\APP\plugins\themes\rumahJurnal\RumahJurnalThemePlugin', '\RumahJurnalThemePlugin');
}