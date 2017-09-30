function [opt] = getOpts(expt_name)
	
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
		            
		case 'perceptual_mod'
			opt = getDefaultOpts();
			opt.which_algs_paths = {'p0','ref','p1'};
%             opt.gt_path = 'ref';
            opt.Nimgs = 2000;                        % number of images to test
            opt.Npairs = 105;                        % number of paired comparisons per HIT
            opt.Npractice = 5;                     % number of practice trials per HIT (number of non-practice trials is opt.Npairs-opt.Npractice)
            opt.Nhits_per_alg = 100;                 % number of HITs

            opt.ut_id = '94149d445af4a3af8dd5d41614353c0b'; % set this using http://uniqueturker.myleott.com/
% 			opt.base_url = 'https://eecs.berkeley.edu/~rich.zhang/research/2017_07_perceptual/easy_collect_richard/';
% 			opt.base_url = 'https://eecs.berkeley.edu/~rich.zhang/research/2017_07_perceptual/easy_collect_richard_adobe_32/';
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
		            
        otherwise
			error(sprintf('no opts defined for experiment %s',expt_name));
	end
	
	opt.expt_name = expt_name;
end