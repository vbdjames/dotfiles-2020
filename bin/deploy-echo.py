#!/usr/bin/env python

import urllib2, re, os

print ""
print "***************************************************"
print "* This script assists in the deployment of Echo   *"
print "* Agent and Echo Admin to the alternate cluster   *"
print "*                                                 *"
print "* This is an Alpha release - pay close attention  *"
print "* and be prepared to abort if anything goes wrong *"
print "***************************************************"
print ""

def get_redirected_url(url):
    opener = urllib2.build_opener(urllib2.HTTPRedirectHandler)
    request = opener.open(url)
    return request.url

url = get_redirected_url("http://chesechoprimary.internal")
agent_host = re.search('prod[1-9]echo', url).group(0)

host_map = {
        'prod1echo' : { 
            'active_primary' : 'prod1echo',
            'active_secondary' : 'prod2echo',
            'target_primary' : 'prod3echo',
            'target_secondary' : 'prod4echo'
            },
        'prod2echo' : { 
            'active_primary' : 'prod1echo',
            'active_secondary' : 'prod2echo',
            'target_primary' : 'prod3echo',
            'target_secondary' : 'prod4echo'
            },
        'prod3echo' : { 
            'active_primary' : 'prod3echo',
            'active_secondary' : 'prod4echo',
            'target_primary' : 'prod1echo',
            'target_secondary' : 'prod2echo'
            },
        'prod4echo' : { 
            'active_primary' : 'prod3echo',
            'active_secondary' : 'prod4echo',
            'target_primary' : 'prod1echo',
            'target_secondary' : 'prod2echo'
            },
        'prod5echo' : { 
            'active_primary' : 'prod5echo',
            'active_secondary' : 'prod5echo'
            },
        'prod1echo' : { 
            'active_primary' : 'prod5echo',
            'active_secondary' : 'prod6echo',
            }
        }



