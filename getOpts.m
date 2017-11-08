function [opt] = getOpts(expt_name, simultaneous, time_image_display, time_image_gap, time_button_delay, subset)
	switch expt_name
        
		case 'example_expt'
			opt = getDefaultOpts();
			opt.which_algs_paths = {'my_alg','baseline_alg'};
			opt.Nimgs = 1000;
			opt.ut_id = '94149d445af4a3af8dd5d41614353c0b'; % set this using http://uniqueturker.myleott.com/
			opt.base_url = 'https://www.mywebsite.com/example_expt_data/';
			opt.instructions_file = './instructions_basic.html';
			opt.short_instructions_file = './short_instructions_basic.html';
			opt.consent_file = './consent_basic.html';
			opt.use_vigilance = false;
			opt.paired = true;

		case 'perceptual'
			opt = getDefaultOpts();
			opt.which_algs_paths = {'p0','p1'};
            opt.gt_path = 'ref';
			opt.Nimgs = 100;
			opt.ut_id = '94149d445af4a3af8dd5d41614353c0b'; % set this using http://uniqueturker.myleott.com/
			opt.base_url = 'https://eecs.berkeley.edu/~rich.zhang/research/2017_07_perceptual/easy_collect_richard/';
			opt.instructions_file = './instructions_basic.html';
			opt.short_instructions_file = './short_instructions_basic.html';
			opt.consent_file = './consent_basic.html';
			opt.use_vigilance = false;
			opt.paired = true;
		            
		case 'perceptual_mod_adobe'
			opt = getDefaultOpts();
			opt.which_algs_paths = {'p0','ref','p1'};
%             opt.gt_path = 'ref';
            opt.Nimgs = 2000;                        % number of images to test
            opt.Npairs = 105;                        % number of paired comparisons per HIT
            opt.Npractice = 5;                     % number of practice trials per HIT (number of non-practice trials is opt.Npairs-opt.Npractice)
            opt.Nhits_per_alg = 100;                 % number of HITs

            opt.ut_id = '94149d445af4a3af8dd5d41614353c0b'; % set this using http://uniqueturker.myleott.com/
			opt.base_url = 'https://eecs.berkeley.edu/~rich.zhang/research/2017_07_perceptual/easy_collect_richard_adobe_32_4/';
			opt.instructions_file = './instructions_basic_mod.html';
			opt.short_instructions_file = './short_instructions_basic.html';
			opt.consent_file = './consent_basic_mod.html';

            opt.use_vigilance = true;
			opt.vigilance_path = 'vigilance';
            opt.Nvigilance = 1000;                  % number of vigilance images available
        	opt.vigilance_freq = .1;               % percent of trials that are vigilance tests
            
            opt.im_height = 32;                    % dimensions at which to display the stimuli
            opt.im_width = 32;                     %
            
            opt.paired = true;

		case 'perceptual_mod_amt'
			opt = getDefaultOpts();
			opt.which_algs_paths = {'p0','ref','p1'};
%             opt.gt_path = 'ref';
            opt.Nimgs = 27500;                        % number of images to test
            opt.Npairs = 810;                        % number of paired comparisons per HIT
%             opt.Npairs = 11;                        % number of paired comparisons per HIT
            opt.Npractice = 10;                     % number of practice trials per HIT (number of non-practice trials is opt.Npairs-opt.Npractice)
%             opt.Npairs = 10;                        % number of paired comparisons per HIT
%             opt.Npractice = 5;                     % number of practice trials per HIT (number of non-practice trials is opt.Npairs-opt.Npractice)
            opt.Nhits_per_alg = 25;                 % number of HITs

            opt.ut_id = '9fb34d6b841e054b4035cb67409d4108'; % set this using http://uniqueturker.myleott.com/
			opt.base_url = 'http://colorization.eecs.berkeley.edu/_tmp_host/2017_09_perceptual/vgg_collect_32_VGG_5/';
            opt.instructions_file = './instructions_basic_mod.html';
			opt.short_instructions_file = './short_instructions_basic.html';
			opt.consent_file = './consent_basic_mod.html';

            opt.use_vigilance = true;
			opt.vigilance_path = 'vigilance';
            opt.Nvigilance = 1000;                  % number of vigilance images available
%         	opt.vigilance_freq = .1;               % percent of trials that are vigilance tests
        	opt.vigilance_freq = .025;               % percent of trials that are vigilance tests
            
            opt.im_height = 32;                    % dimensions at which to display the stimuli
            opt.im_width = 32;                     %
            
            opt.paired = true;

        case 'diversity'
			opt = getDefaultOpts();
			opt.algs_paths = {'alg0','alg1','alg2'};
%             opt.gt_path = 'ref';
            opt.Nimgs = 5000;                        % number of images available to test
%             opt.Npairs = 265;                        % number of paired comparisons per HIT
%             opt.Npractice = 15;                     % number of practice trials per HIT (number of non-practice trials is opt.Npairs-opt.Npractice)
            opt.Npairs = 260;                        % number of paired comparisons per HIT
            opt.Npractice = 10;                     % number of practice trials per HIT (number of non-practice trials is opt.Npairs-opt.Npractice)
            opt.Nhits = 20;                 % number of HITs

            opt.ut_id = '5b2626b3f00f88934f89858037008810'; % set this using http://uniqueturker.myleott.com/
            opt.base_url = 'http://colorization.eecs.berkeley.edu/_tmp_host/2017_09_perceptual/amt1/';
            opt.instructions_file = './instructions_basic_mod.html';
			opt.short_instructions_file = './short_instructions_basic.html';
			opt.consent_file = './consent_basic_mod.html';

            opt.use_vigilance = true;
			opt.vigilance_path = 'vigilance_jnd';
            opt.Nvigilance = 100;                  % number of vigilance images available
        	opt.vigilance_freq = .2;               % percent of trials that are vigilance tests

            % display times
            opt.time_image_display = 1000;          % amount of time to display each image
            opt.time_image_gap = 500;               % amount of time to wait between images
            opt.time_button_delay = 250;            % amount of time to wait for the same/not same button to appear

            opt.im_height = 256;                    % dimensions at which to display the stimuli
            opt.im_width = 256;                     %
            
            opt.paired = true;

        
        otherwise
			error(sprintf('no opts defined for experiment %s',expt_name));
    end
    opt.time_image_display = time_image_display;          % amount of time to display each image
    opt.time_image_gap = time_image_gap;               % amount of time to wait between images
    opt.time_button_delay = time_button_delay;            % amount of time to wait for the same/not same button to appear
    opt.subset = subset;
    opt.simultaneous = simultaneous;
    
    if(opt.simultaneous)
        simultaneous_str = 'simul';
    else
        simultaneous_str = 'seq';
    end

% 	opt.expt_name = strcat(expt_name,'_',simultaneous_str,'_',opt.subset,'_',num2str(opt.time_image_display),'_',num2str(opt.time_image_gap),'_',num2str(opt.time_button_delay));
	opt.expt_name = strcat(opt.subset,'_',num2str(opt.time_image_display),'_',num2str(opt.time_image_gap),'_',num2str(opt.time_button_delay));
end
