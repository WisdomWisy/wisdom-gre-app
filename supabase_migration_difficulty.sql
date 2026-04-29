-- SQL Migration to add difficulty_preference to profiles table

-- Add difficulty_preference column with default value 'all'
ALTER TABLE public.profiles
ADD COLUMN IF NOT EXISTS difficulty_preference TEXT DEFAULT 'all';

-- Update existing profiles to have the default value just in case
UPDATE public.profiles
SET difficulty_preference = 'all'
WHERE difficulty_preference IS NULL;

-- Optional: Add a check constraint to ensure only valid difficulties are stored
ALTER TABLE public.profiles
ADD CONSTRAINT valid_difficulty_preference CHECK (difficulty_preference IN ('all', 'easy', 'medium', 'hard'));
